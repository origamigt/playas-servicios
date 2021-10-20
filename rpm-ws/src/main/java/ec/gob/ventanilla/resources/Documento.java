package ec.gob.ventanilla.resources;

//import com.google.gson.Gson;

import ec.gob.ventanilla.async.SGRService;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.ImagesCertificados;
import ec.gob.ventanilla.entity.PubPersona;
import ec.gob.ventanilla.model.DataModel;
import ec.gob.ventanilla.model.DocumentoFD;
import ec.gob.ventanilla.model.DocumentoModel;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.util.OmegaUploader;
import org.apache.commons.io.FileUtils;
import org.apache.pdfbox.io.IOUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/rpm-ventanilla/api/documento")
public class Documento {

    @Autowired
    private OmegaUploader omegaUploader;
    @Autowired
    private SGRService sgrService;
    @Autowired
    private AppProps appProps;

    @RequestMapping(value = "/codigo/{codigoVerificacion}/tipo/{tipo}", method = RequestMethod.GET)
    public List<ImagesCertificados> downloadPDFFileImage2(@PathVariable String codigoVerificacion,
                                                          @PathVariable String tipo) {
        Integer codigo = tipo.equals("C") ? 1 : 2;
        String descripcion = pathFileDocumento(codigoVerificacion, "/informacion/", codigo);
        String pathFile = pathFileDocumento(codigoVerificacion, "/tipo/", codigo);
        List<ImagesCertificados> files = new ArrayList<>();
        files.add(new ImagesCertificados(descripcion));
        if (pathFile != null) {
            String fileName, tempName;
            BufferedImage bim;
            try (final PDDocument document = PDDocument.load(new File(pathFile))) {
                PDFRenderer pdfRenderer = new PDFRenderer(document);
                for (int page = 0; page < document.getNumberOfPages(); ++page) {
                    bim = pdfRenderer.renderImageWithDPI(page, 500, ImageType.RGB);
                    tempName = codigoVerificacion + "-" + page + ".png";
                    fileName = appProps.getOutputDir() + "imagenes_tramites/" + tempName;
                    files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + "imagen/" + tempName));
                    ImageIOUtil.writeImage(bim, fileName, 500);
                }
            } catch (IOException e) {
                files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + "imagen/" + "sin_resultados.png"));
                System.err.println("Exception while trying to create pdf document - " + e);
            }
        } else {
            files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + "imagen/" + "sin_resultados.png"));
        }
        return files;
    }

    private String pathFileDocumento(String codigoVerificacion, String path, Integer tipo) {
        String pathFile;
        RestTemplate restTemplate = new RestTemplate();
        if (!path.contains("informacion")) {
            System.out.println(appProps.getRpConsultarOid() + codigoVerificacion + path + tipo);
            Long oidDocumento = restTemplate.getForObject(appProps.getRpConsultarOid() + codigoVerificacion + path + tipo, Long.class);
            if (oidDocumento != null && oidDocumento > 0L) {
                System.out.println("oidDocumento "  + oidDocumento);
                pathFile = appProps.getOutputDir() + codigoVerificacion + ".pdf";
                File file = new File(pathFile);
                try (FileOutputStream fos = new FileOutputStream(file)) {
                    omegaUploader.streamFile(oidDocumento, fos, appProps.getDocUrl());
                } catch (IOException e) {
                    e.printStackTrace();
                    return null;
                }
            } else {
                pathFile = appProps.getOutputDir() + "documento_no_encontrado.pdf";
            }
        } else {
            pathFile = restTemplate.getForObject(appProps.getRpConsultarOid() + codigoVerificacion + path + tipo, String.class);
        }
        return pathFile;
    }

    @RequestMapping(value = "/imagen/{nombre}", method = RequestMethod.GET)
    public @ResponseBody
    byte[] getImage(@PathVariable String nombre) throws IOException {
        File initialFile = new File(appProps.getOutputDir() + "imagenes_tramites/" + nombre + ".png");
        InputStream targetStream = new FileInputStream(initialFile);
        return IOUtils.toByteArray(targetStream);
    }

    @RequestMapping(value = "/verificarArchivo", method = RequestMethod.POST)
    public ResponseEntity<?> verificarArchivo(@RequestBody DocumentoModel model) {
        try {
            return new ResponseEntity<>(sgrService.validarDocumentoFD(model), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.ACCEPTED);
        }
    }

    @RequestMapping(value = "/descargarRequisito/{id}", method = RequestMethod.GET, produces =
            "application/pdf")
    public ResponseEntity<byte[]> downloadPDFFile(@PathVariable String id) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=Requisito_.pdf");

        return new ResponseEntity<>(documento(id), headers, HttpStatus.OK);
    }

    @RequestMapping(value = "/descargarRequisito", method = RequestMethod.POST)
    public ResponseEntity<?> descargarRequisito(@RequestBody DocumentoModel model) {
        try {
            return new ResponseEntity<>(sgrService.validarDocumentoFD(model), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.ACCEPTED);
        }
    }

    private byte[] documento(String documento) {
        File file = new File(appProps.getOutputDir() + "Requisito_" + documento);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            omegaUploader.streamFile(Long.parseLong(documento.replaceAll(".pdf", "")), fos, appProps.getDocUrl());
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        try {
            return Files.readAllBytes(file.toPath());
        } catch (IOException e) {
            return null;
        }


    }

}
