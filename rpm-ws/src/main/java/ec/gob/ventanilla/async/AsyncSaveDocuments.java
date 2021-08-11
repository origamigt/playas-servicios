package ec.gob.ventanilla.async;

import com.google.gson.Gson;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import ec.gob.ventanilla.util.OmegaUploader;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.IOException;

@Service
public class AsyncSaveDocuments {

    @Autowired
    private AppProps appProps;
    @Autowired
    private PubSolicitudRepository psr;
    @Autowired
    private OmegaUploader omegaUploader;
    private Boolean update = Boolean.FALSE;

    @Async
    public void asyncDocumentSolicitud(PubSolicitud pubSolicitud, Long idSolicitud) {
        pubSolicitud.setId(null);
        //System.out.println("holi" + pubSolicitud.getImage1());
        if (pubSolicitud.getImage1() != null) {
            pubSolicitud.setOidDocument(
                    omegaUploader.uploadFile(new ByteArrayInputStream(Base64.decodeBase64(pubSolicitud.getImage1())),
                            pubSolicitud.getSolCedula(), "gzip", appProps.getDocUrl()));
            update = Boolean.TRUE;
        }
        if (pubSolicitud.getImage2() != null) {
            pubSolicitud.setOidDocument2(
                    omegaUploader.uploadFile(new ByteArrayInputStream(Base64.decodeBase64(pubSolicitud.getImage2())),
                            pubSolicitud.getSolCedula(), "gzip", appProps.getDocUrl()));
            update = Boolean.TRUE;
        }

        if (pubSolicitud.getImage3() != null) {
            pubSolicitud.setOidDocument3(
                    omegaUploader.uploadFile(new ByteArrayInputStream(Base64.decodeBase64(pubSolicitud.getImage3())),
                            pubSolicitud.getSolCedula(), "gzip", appProps.getDocUrl()));
            update = Boolean.TRUE;
        }
        pubSolicitud.setId(idSolicitud);
        try {
            psr.save(pubSolicitud);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (update) {
            Gson gson = new Gson();
            HttpClient httpClient = HttpClientBuilder.create().build();
            HttpPost httpPost = new HttpPost(appProps.getRpActualizarDocumentos());
            httpPost.setEntity(new StringEntity(gson.toJson(pubSolicitud), "UTF-8"));
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
            try {
                httpClient.execute(httpPost);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
