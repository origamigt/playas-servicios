package ec.gob.ventanilla.async;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AclUser;
import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.model.DatosProforma;
import ec.gob.ventanilla.model.DocumentoFD;
import ec.gob.ventanilla.model.DocumentoModel;
import ec.gob.ventanilla.model.FirmaElectronica;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import ec.gob.ventanilla.util.JsonDateDeserializer;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

@Service
public class SGRService {

    @Autowired
    private AppProps appProps;
    @Autowired
    private PubSolicitudRepository pubSolicitudRepository;

    @Autowired
    private AsyncSaveDocuments asyncSolicitud;

    @Async
    public void iniciarTramite(PubSolicitud solicitud) {
        try {
            Long idSolicitud = solicitud.getId();
            String image1 = solicitud.getImage1();
            String image2 = solicitud.getImage2();
            String image3 = solicitud.getImage3();
            Date fecha = solicitud.getFechaSolicitud();
            AclUser aclUser = solicitud.getUser();
            solicitud.setFechaSolicitud(null);
            solicitud.setUser(null);
            solicitud.setId(null);
            solicitud.setImage1(null);
            solicitud.setImage2(null);
            solicitud.setImage3(null);
            Gson gson = new Gson();
            System.out.println(gson.toJson(solicitud));
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getRpIniciarTramite());
            httpPost.setEntity(new StringEntity(gson.toJson(solicitud), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");

            ExecutorService executorService = Executors.newSingleThreadExecutor();
            Future<HttpResponse> futureResponse = executorService.submit(() -> httpClient.execute(httpPost));

            HttpResponse httpResponse = futureResponse.get(60, TimeUnit.SECONDS);
            solicitud.setUser(aclUser);
            solicitud.setFechaSolicitud(fecha);
            solicitud.setId(idSolicitud);
            solicitud.setImage1(image1);
            solicitud.setImage2(image2);
            solicitud.setImage3(image3);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(httpResponse.getEntity().getContent()));
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();

                DatosProforma datosProforma = gson.fromJson(sb.toString(), DatosProforma.class);
                if (datosProforma != null && datosProforma.getNumerotramite() != null) {
                    solicitud.setNumeroTramite(datosProforma.getNumerotramite());
                    solicitud.setIngresado(Boolean.TRUE);
                    if (datosProforma.getFechaingreso() != null) {
                        solicitud.setFechaIngreso(new Date(datosProforma.getFechaingreso()));
                    }
                    if (datosProforma.getFechaentrega() != null) {
                        solicitud.setFechaEntrega(new Date(datosProforma.getFechaentrega()));
                    }
                }
            }

            pubSolicitudRepository.save(solicitud);
            asyncSolicitud.asyncDocumentSolicitud(solicitud, idSolicitud);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Async
    public void iniciarTramiteSolicitudInscripcion(PubSolicitud solicitud) {
        try {
            Long idSolicitud = solicitud.getId();
            Date fecha = solicitud.getFechaSolicitud();
            AclUser aclUser = solicitud.getUser();
            solicitud.setFechaSolicitud(null);
            solicitud.setUser(null);
            solicitud.setId(null);
            Gson gson = new Gson();
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getRpIniciarTramiteSolicitudInscripcion());
            httpPost.setEntity(new StringEntity(gson.toJson(solicitud), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");

            ExecutorService executorService = Executors.newSingleThreadExecutor();
            Future<HttpResponse> futureResponse = executorService.submit(() -> httpClient.execute(httpPost));
            HttpResponse httpResponse = futureResponse.get(60, TimeUnit.SECONDS);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(httpResponse.getEntity().getContent()));
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();

                DatosProforma datosProforma = gson.fromJson(sb.toString(), DatosProforma.class);
                if (datosProforma != null && datosProforma.getNumerotramite() != null) {
                    solicitud.setNumeroTramite(datosProforma.getNumerotramite());
                    solicitud.setIngresado(Boolean.TRUE);
                    if (datosProforma.getFechaingreso() != null) {
                        solicitud.setFechaIngreso(new Date(datosProforma.getFechaingreso()));
                    }
                    if (datosProforma.getFechaentrega() != null) {
                        solicitud.setFechaEntrega(new Date(datosProforma.getFechaentrega()));
                    }
                }
            }
            solicitud.setFechaSolicitud(fecha);
            solicitud.setUser(aclUser);
            solicitud.setId(idSolicitud);
            pubSolicitudRepository.save(solicitud);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Async
    public void iniciarTramiteInscripcion(PubSolicitud solicitud) {
        try {
            Long idSolicitud = solicitud.getId();
            AclUser aclUser = solicitud.getUser();
            solicitud.setUser(null);
            solicitud.setId(null);
            Gson gson = new Gson();
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getRpIniciarTramiteInscripcion());
            httpPost.setEntity(new StringEntity(gson.toJson(solicitud), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");



            System.out.println(appProps.getRpIniciarTramiteInscripcion());
            System.out.println(gson.toJson(solicitud));

            ExecutorService executorService = Executors.newSingleThreadExecutor();
            Future<HttpResponse> futureResponse = executorService.submit(() -> httpClient.execute(httpPost));
            HttpResponse httpResponse = futureResponse.get(60, TimeUnit.SECONDS);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(httpResponse.getEntity().getContent()));
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();

                DatosProforma datosProforma = gson.fromJson(sb.toString(), DatosProforma.class);
                if (datosProforma != null && datosProforma.getNumerotramite() != null) {
                    solicitud.setNumeroTramite(datosProforma.getNumerotramite());
                    solicitud.setIngresado(Boolean.TRUE);
                    if (datosProforma.getFechaingreso() != null) {
                        solicitud.setFechaIngreso(new Date(datosProforma.getFechaingreso()));
                    }
                    if (datosProforma.getFechaentrega() != null) {
                        solicitud.setFechaEntrega(new Date(datosProforma.getFechaentrega()));
                    }
                }
            }
            solicitud.setUser(aclUser);
            solicitud.setId(idSolicitud);
            pubSolicitudRepository.save(solicitud);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public DatosProforma actualizarRequisitosInscripcion(PubSolicitud solicitud) {
        DatosProforma datosProforma = null;
        try {
            Long idSolicitud = solicitud.getId();
            AclUser aclUser = solicitud.getUser();
            solicitud.setUser(null);
            solicitud.setId(null);
            Gson gson = new Gson();
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getRpActualizarRequisitos());
            httpPost.setEntity(new StringEntity(gson.toJson(solicitud), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");

            ExecutorService executorService = Executors.newSingleThreadExecutor();
            Future<HttpResponse> futureResponse = executorService.submit(() -> httpClient.execute(httpPost));
            HttpResponse httpResponse = futureResponse.get(60, TimeUnit.SECONDS);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(httpResponse.getEntity().getContent()));
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                in.close();

                datosProforma = gson.fromJson(sb.toString(), DatosProforma.class);
                if (datosProforma != null && datosProforma.getNumerotramite() != null) {
                    solicitud.setNumeroTramite(datosProforma.getNumerotramite());
                    solicitud.setIngresado(Boolean.TRUE);
                    if (datosProforma.getFechaingreso() != null) {
                        solicitud.setFechaIngreso(new Date(datosProforma.getFechaingreso()));
                    }
                    if (datosProforma.getFechaentrega() != null) {
                        solicitud.setFechaEntrega(new Date(datosProforma.getFechaentrega()));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return datosProforma;
    }

    public DocumentoFD validarDocumentoFD(DocumentoModel model) {
        DocumentoFD documentoFD = new DocumentoFD();
        try {
            File directory = new File(appProps.getOutputDir());
            if (!directory.exists()) {
                directory.mkdir();
            }
            GsonBuilder builder = new GsonBuilder().setDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz")
                    .registerTypeAdapter(Date.class, new JsonDateDeserializer());
            Gson gson = builder.create();
            FirmaElectronica firmaElectronica = new FirmaElectronica();
            String archivo = appProps.getOutputDir() + model.getNombre();


            FileUtils.writeByteArrayToFile(new File(archivo), model.getMultipartFile());

            firmaElectronica.setArchivoFirmado(archivo);

            System.out.println(appProps.getFirmaElectronica() + "verificarDocumento");
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getFirmaElectronica() + "verificarDocumento");
            httpPost.setEntity(new StringEntity(gson.toJson(firmaElectronica), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");

            ExecutorService executorService = Executors.newSingleThreadExecutor();
            Future<HttpResponse> futureResponse = executorService.submit(() -> httpClient.execute(httpPost));
            HttpResponse httpResponse = futureResponse.get(60, TimeUnit.SECONDS);
            if (httpResponse != null) {
                BufferedReader in = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent(), StandardCharsets.UTF_8), 8);
                String inputLine;
                StringBuilder sb = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    sb.append(inputLine);
                }
                System.out.println(sb.toString());
                in.close();
                documentoFD = gson.fromJson(sb.toString(), DocumentoFD.class);
            }
        } catch (Exception e) {
            e.printStackTrace();
            documentoFD.setProcess("Error al validar");
        }
        return documentoFD;
    }

}
