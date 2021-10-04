package ec.gob.ventanilla.async;

import com.google.gson.Gson;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.model.payphone.*;
import ec.gob.ventanilla.repository.ActoRepository;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import ec.gob.ventanilla.repository.ResponseCreateRepository;
import ec.gob.ventanilla.repository.ResponseReverseRepository;
import ec.gob.ventanilla.security.MD5PasswordEncoder;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.bouncycastle.crypto.engines.AESEngine;
import org.bouncycastle.crypto.modes.CBCBlockCipher;
import org.bouncycastle.crypto.paddings.PaddedBufferedBlockCipher;
import org.bouncycastle.crypto.params.KeyParameter;
import org.bouncycastle.crypto.params.ParametersWithIV;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;

@Service
public class PayPhoneService {

    @Autowired
    private SGRService sgrService;
    @Autowired
    private ResponseCreateRepository responseCreateRepository;
    @Autowired
    private ResponseReverseRepository responseReverseRepository;
    @Autowired
    private EmailService emailService;
    @Autowired
    private ActoRepository actoRepository;
    @Autowired
    private PubSolicitudRepository solicitudRepository;
    @Autowired
    private AppProps appProps;

    @Async
    public void payOnlinePayPhone(Tarjeta tarjeta, PubSolicitud pubSolicitud) {
        try {

            Integer intentos = 0;
            ResponseCreate responseCreate = null;
            Base64 base64 = new Base64();
            Gson gson = new Gson();
            tarjeta.setCardNumber(tarjeta.getCardNumber().trim());
            tarjeta.setExpirationMonth(tarjeta.getExpiryDate().substring(0, 2));
            tarjeta.setExpirationYear(tarjeta.getExpiryDate().substring(3, 5));

            String card = gson.toJson(tarjeta);

            byte[] inputBytes = card.getBytes("UTF-8");
            byte[] keyC = null;//appProps.getPayphoneApiCoding().getBytes("UTF-8");

            PaddedBufferedBlockCipher cipher = new PaddedBufferedBlockCipher(new CBCBlockCipher(new AESEngine()));
            ParametersWithIV keyParamWithIV = new ParametersWithIV(new KeyParameter(keyC), new byte[16]);

            cipher.init(true, keyParamWithIV);
            byte[] outputBytes = new byte[cipher.getOutputSize(inputBytes.length)];

            int length = cipher.processBytes(inputBytes, 0, inputBytes.length, outputBytes, 0);
            cipher.doFinal(outputBytes, length);
            String encodedString = new String(base64.encode(outputBytes));

            Double result = pubSolicitud.getTotal() * 100.0;

            Integer total = result.intValue();
            String telf = pubSolicitud.getBenTelefono();
            if (telf.startsWith("0")) {
                telf = pubSolicitud.getBenTelefono().substring(1);
            }
            TransactionCreate transactionCreate = new TransactionCreate(encodedString,
                    "593" + telf,
                    pubSolicitud.getBenCorreo(),
                    tarjeta.getTipoTransaccion(),
                    pubSolicitud.getBenDocumento(),
                    total,
                    0,
                    total,
                    tarjeta.getIdSolicitud().toString(),
                    0,
                    null
            );
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getPayphoneTransactionCreate());
            httpPost.setEntity(new StringEntity(gson.toJson(transactionCreate), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
            //  httpPost.setHeader("Authorization", "Bearer " + appProps.getPayphoneBearerApiToken());
            HttpResponse httpResponse = httpClient.execute(httpPost);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(httpResponse.getEntity().getContent()));
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();
                responseCreate = gson.fromJson(sb.toString(), ResponseCreate.class);
                if (responseCreate != null) {
                    if (responseCreate.getStatusCode() != null) {
                        responseCreate.setFecha(new Date());
                        responseCreate.setIdSolicitud(pubSolicitud.getId());
                        responseCreateRepository.save(responseCreate);
                        if (responseCreate.getStatusCode().equals("3")) {
                            sgrService.iniciarTramite(pubSolicitud);
                        } else {
                            emailService.sendMail(pubSolicitud.getSolCorreo(), "Solicitud de Trámite",
                                    htmlRechazoTramite(responseCreate.getMessage()));
                        }
                    } else {
                        emailService.sendMail(pubSolicitud.getSolCorreo(), "Solicitud de Trámite",
                                htmlRechazoTramite(appProps.getPayphoneError()));
                    }
                } else {
                    emailService.sendMail(pubSolicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(appProps.getPayphoneError()));
                }
            } else {
                emailService.sendMail(pubSolicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(appProps.getPayphoneError()));
            }
            /*do {
                intentos++;
                if (intentos <= 3) {

                } else {
                    emailService.sendMail(pubSolicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(SisVars.errorPayPhone));
                }
            } while (intentos  <=  3);*/

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            emailService.sendMail(pubSolicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(appProps.getPayphoneError()));
        }
    }

    @Async
    public void reverseOnlinePayPhone(Long idSolicitud) {
        try {
            ResponseReverse responseReverse;
            Reverse reverse = new Reverse(idSolicitud.toString());
            Gson gson = new Gson();

            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getPayphoneReverseClient());
            httpPost.setEntity(new StringEntity(gson.toJson(reverse), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
            //   httpPost.setHeader("Authorization", "Bearer " + appProps.getPayphoneBearerApiToken());

            HttpResponse httpResponse = httpClient.execute(httpPost);

            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent(), "UTF-8"), 8);
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();
                if (sb.toString().contains("true")) {
                    responseReverse = new ResponseReverse();
                    responseReverse.setIdSolicitud(idSolicitud);
                    responseReverse.setMessage("TRANSACCIÓN REALIZADA");
                    responseReverse.setErrorCode(0);
                    responseReverseRepository.save(responseReverse);
                } else {
                    responseReverse = gson.fromJson(sb.toString(), ResponseReverse.class);
                    if (responseReverse != null) {
                        responseReverse.setIdSolicitud(idSolicitud);
                        responseReverseRepository.save(responseReverse);
                    }
                }

            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public CreateBtn linkPagoPayPhone(PubSolicitud pubSolicitud) {
        try {
            String url = appProps.getDominio() + "pagos/transaccionExitosa/";
            Gson gson = new Gson();
            Double result = pubSolicitud.getTotal() * 100.0;
            Integer total = result.intValue();
            TransactionCreate transactionCreate = new TransactionCreate();
            transactionCreate.setAmount(total);
            transactionCreate.setTax(0);
            transactionCreate.setAmountWithTax(0);
            transactionCreate.setAmountWithoutTax(total);
            transactionCreate.setCurrency("USD");
            transactionCreate.setResponseUrl(url + "?code=" + new MD5PasswordEncoder().encode(url + pubSolicitud.getId()));
            if (pubSolicitud.getEstado().equals("INSCRIPCION")) {
                transactionCreate.setReference("Trámite " + pubSolicitud.getNumeroTramiteInscripcion().toString());
            } else {
                transactionCreate.setReference(actoRepository.findById(pubSolicitud.getTipoSolicitud()).get().getActo());
            }
            transactionCreate.setClientTransactionId(pubSolicitud.getId().toString());
            transactionCreate.setOneTime(Boolean.TRUE);
            transactionCreate.setExpireIn(2800);

            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getPayphoneBtnPago());
            httpPost.setEntity(new StringEntity(gson.toJson(transactionCreate), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
            httpPost.setHeader("Authorization", "Bearer " + appProps.getPayphoneBtnBearerApiToken());
            HttpResponse httpResponse = httpClient.execute(httpPost);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent(), "UTF-8"), 8);
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();
                CreateBtn response = gson.fromJson(sb.toString(), CreateBtn.class);
                if (response != null) {

                    return response;
                } else {
                    return new CreateBtn();
                }
            } else {
                return new CreateBtn();
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            return new CreateBtn();
        }

    }

    public ResponseCreate verificarPagoBtn(ResponseBtn responseBtn) {
        PubSolicitud solicitud = solicitudRepository.encontrarPorId(Long.valueOf(responseBtn.getClientTxId()));
        try {
            ResponseCreate responseCreate = new ResponseCreate();
            if (solicitud != null && !solicitud.getProcesando()) {
                solicitud.setProcesando(Boolean.TRUE);
                solicitud = solicitudRepository.save(solicitud);
                Gson gson = new Gson();
                System.out.println(gson.toJson(responseBtn));
                HttpClient httpClient = HttpClientBuilder.create().build();
                HttpPost httpPost = new HttpPost(appProps.getPayphoneConfirmPago());
                httpPost.setEntity(new StringEntity(gson.toJson(responseBtn), "UTF-8"));
                httpPost.setHeader("Content-type", "application/json; charset=utf-8");
                httpPost.setHeader("Authorization", "Bearer " + appProps.getPayphoneBtnBearerApiToken());
                HttpResponse httpResponse = httpClient.execute(httpPost);
                if (httpResponse != null) {
                    BufferedReader in = new BufferedReader(
                            new InputStreamReader(httpResponse.getEntity().getContent()));
                    String inputLine;
                    StringBuilder sb = new StringBuilder();
                    while ((inputLine = in.readLine()) != null) {
                        sb.append(inputLine);
                    }
                    in.close();
                    System.out.println("sb.toString: " + sb.toString());
                    responseCreate = gson.fromJson(sb.toString(), ResponseCreate.class);
                    if (responseCreate != null) {
                        System.out.println("responseCreate:  " + responseCreate.toString());
                        if (responseCreate.getStatusCode() != null) {
                            responseCreate.setFecha(new Date());
                            responseCreate.setIdSolicitud(solicitud.getId());
                            responseCreate.setActo(solicitud.getTipoSolicitud() == 0 ? ("INSCRIPCIÓN TRÁMITE #" + solicitud.getNumeroTramiteInscripcion()) : actoRepository.findById(solicitud.getTipoSolicitud()).get().getActo());
                            responseCreate.setTotal(solicitud.getTotal());
                            responseCreate = responseCreateRepository.save(responseCreate);

                            if (responseCreate.getStatusCode().equals("3")) {
                                if (solicitud.getTipoSolicitud() != 0) {
                                    sgrService.iniciarTramite(solicitud);
                                } else {
                                    sgrService.iniciarTramiteInscripcion(solicitud);
                                }
                                return responseCreate;
                            } else {
                                emailService.sendMail(solicitud.getSolCorreo(), "Solicitud de Trámite",
                                        htmlRechazoTramite(responseCreate.getMessage()));
                            }
                        } else {
                            emailService.sendMail(solicitud.getSolCorreo(), "Solicitud de Trámite",
                                    htmlRechazoTramite(appProps.getPayphoneError()));
                        }
                    } else {
                        emailService.sendMail(solicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(appProps.getPayphoneError()));
                    }
                } else {
                    emailService.sendMail(solicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(appProps.getPayphoneError()));
                }
            } else {
                responseCreate = responseCreateRepository.findFirstByTransactionIdOrderByIdDesc(responseBtn.getId().toString());
            }
//            System.out.println(responseCreate.toString());
            return responseCreate;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            emailService.sendMail(solicitud.getSolCorreo(), "Solicitud de Trámite", htmlRechazoTramite(appProps.getPayphoneError()));

        }
        return null;
    }

    private String htmlRechazoTramite(String razon) {
        try {

            StringBuilder sb = new StringBuilder();
            // cabecera:
            sb.append("<div> <img src=\"").append(appProps.getDominio()).append("/resources/images/mailhead1.png\" /> </div>");
            sb.append("<h1> Solicitud de Trámite </h1>");
            // mensaje:
            String mensaje = "El trámite que solicito mediante Pago en Linea no pudo ser Completado.<br/>"
                    + "Por el siguiente motivo: " + razon + ".<br/>"
                    + "Una vez solicionado puede Intentar Nuevamente";
            sb.append("<p>").append(mensaje).append("</p>");
            // footer:
            sb.append("<p>Dirección: Clodoveo Carrión y Av.Orillas del Zamora <br/>");
            sb.append("Teléfono:  +593073702350.</P>");
            return sb.toString();
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }

}
