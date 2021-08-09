package ec.gob.ventanilla.resources;

//import com.google.gson.Gson;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.ImagesCertificados;
import ec.gob.ventanilla.model.DataModel;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.util.OmegaUploader;
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
@RequestMapping("/api/document")
public class Documento {

    @Autowired
    private OmegaUploader omegaUploader;

    @Autowired
    private AppLogsRepository appLogsRepository;
    @Autowired
    private AppProps appProps;
    private AppLogs appLogs;

    @RequestMapping(value = "/codigoVerificacion/{codigoVerificacion}", method = RequestMethod.GET)
    public ResponseEntity<?> existeCertificado(@PathVariable(name = "codigoVerificacion") String codigoVerificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/document/codigoVerificacion/" + codigoVerificacion, null, "existeCertificado", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            RestTemplate restTemplate = new RestTemplate();
            Long oidDocumento = restTemplate.getForObject(appProps.getRpConsultarOidDocument() + codigoVerificacion,
                    Long.class);
            DataModel dataModel = new DataModel(oidDocumento != null || oidDocumento > 0 ? "EXISTE" : "INVÁLIDO");
            return new ResponseEntity<>(dataModel, HttpStatus.OK);
        } catch (RestClientException e) {
            System.out.println(e);
            return new ResponseEntity<>(new DataModel("INVÁLIDO"), HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/codigoVerificacionInscripcion/{codigoVerificacion}", method = RequestMethod.GET)
    public ResponseEntity<?> existeInscripcion(@PathVariable(name = "codigoVerificacion") String codigoVerificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/document/codigoVerificacionInscripcion/" + codigoVerificacion, null, "existeCertificado", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            RestTemplate restTemplate = new RestTemplate();
            Long oidDocumento = restTemplate.getForObject(appProps.getRpConsultarOidDocument() + codigoVerificacion,
                    Long.class);
            DataModel dataModel = new DataModel(oidDocumento != null || oidDocumento > 0 ? "EXISTE" : "INVÁLIDO");
            return new ResponseEntity<>(dataModel, HttpStatus.OK);
        } catch (RestClientException e) {
            System.out.println(e);
            return new ResponseEntity<>(new DataModel("INVÁLIDO"), HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/web/{codigoVerificacion}", method = RequestMethod.GET, produces = "application/pdf")
    public ResponseEntity<byte[]> downloadPDFFile(@PathVariable String codigoVerificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/document/web/" + codigoVerificacion, null, "downloadPDFFile", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        String pathFile = pathFileCertificado(codigoVerificacion);

        Path path = Paths.get(pathFile);
        byte[] pdfContents = null;

        try {
            pdfContents = Files.readAllBytes(path);
        } catch (IOException e) {
            System.out.println(e);
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=" + codigoVerificacion + ".pdf");
        ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(
                pdfContents, headers, HttpStatus.OK);
        return responseEntity;

    }

    @RequestMapping(value = "/webinscripcion/{codigoVerificacion}", method = RequestMethod.GET, produces = "application/pdf")
    public ResponseEntity<byte[]> downloadPDFFileInscripcion(@PathVariable String codigoVerificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/document/webinscripcion/" + codigoVerificacion, null, "downloadPDFFileInscripcion", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        String pathFile = pathFileInscripcion(codigoVerificacion);

        Path path = Paths.get(pathFile);
        byte[] pdfContents = null;

        try {
            pdfContents = Files.readAllBytes(path);
        } catch (IOException e) {
            System.out.println(e);
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=" + codigoVerificacion + ".pdf");
        ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(
                pdfContents, headers, HttpStatus.OK);
        return responseEntity;

    }

    @RequestMapping(value = "/movil/{codigoVerificacion}", method = RequestMethod.GET)
    public List<ImagesCertificados> downloadPDFFileImage(@PathVariable String codigoVerificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/document/movil/" + codigoVerificacion, null, "downloadPDFFileImage", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        String pathFile = pathFileCertificado(codigoVerificacion);
        List<ImagesCertificados> files = new ArrayList<>();
        if (pathFile != null) {
            String fileName, tempName;
            BufferedImage bim;

            try (final PDDocument document = PDDocument.load(new File(pathFile))) {
                PDFRenderer pdfRenderer = new PDFRenderer(document);
                for (int page = 0; page < document.getNumberOfPages(); ++page) {
                    bim = pdfRenderer.renderImageWithDPI(page, 500, ImageType.RGB);
                    tempName = codigoVerificacion + "-" + page + ".png";
                    fileName = appProps.getOutputDir() + tempName;
                    files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + tempName));
                    ImageIOUtil.writeImage(bim, fileName, 500);
                }
                document.close();

            } catch (IOException e) {
                files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + "sin_resultados.png"));
                System.err.println("Exception while trying to create pdf document - " + e);
            }
        } else {
            files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + "sin_resultados.png"));
        }
        return files;
    }

    @RequestMapping(value = "/movil/image/{name}", method = RequestMethod.GET)
    public @ResponseBody

    byte[] getImage(@PathVariable String name) throws IOException {
        File initialFile = new File(appProps.getOutputDir() + name + ".png");
        InputStream targetStream = new FileInputStream(initialFile);
        return IOUtils.toByteArray(targetStream);
    }

    private String pathFileCertificado(String codigoVerificacion) {

        RestTemplate restTemplate = new RestTemplate();
        Long oidDocumento = restTemplate.getForObject(appProps.getRpConsultarOidDocument() + codigoVerificacion, Long.class);
        String pathFile;
        if (oidDocumento > 0L) {
            pathFile = appProps.getOutputDir() + codigoVerificacion + ".pdf";
        } else {
            pathFile = appProps.getOutputDir() + "documento_no_encontrado.pdf";
        }
        if (oidDocumento > 0L) {
            File file = new File(pathFile);
            try (FileOutputStream fos = new FileOutputStream(file)) {
                omegaUploader.streamFile(oidDocumento, fos, appProps.getDocUrl());
                fos.close();
            } catch (IOException e) {
                return null;
            }
            return pathFile;
        }
        return pathFile;
    }

    private String pathFileInscripcion(String codigoVerificacion) {

        RestTemplate restTemplate = new RestTemplate();
        Long oidDocumento = restTemplate.getForObject(appProps.getRpConsultarOidInscripcion() + codigoVerificacion, Long.class);
        String pathFile;
        if (oidDocumento > 0L) {
            pathFile = appProps.getOutputDir() + codigoVerificacion + ".pdf";
        } else {
            pathFile = appProps.getOutputDir() + "documento_no_encontrado.pdf";
        }
        if (oidDocumento > 0L) {
            File file = new File(pathFile);
            try (FileOutputStream fos = new FileOutputStream(file)) {
                omegaUploader.streamFile(oidDocumento, fos, appProps.getDocUrl());
                fos.close();
            } catch (IOException e) {
                return null;
            }
            return pathFile;
        }
        return pathFile;
    }

    @RequestMapping(value = "/validation/{codigoVerificacion}/tipo/{type}", method = RequestMethod.GET, produces = "application/pdf")
    public ResponseEntity<byte[]> downloadPDFFile(@PathVariable String codigoVerificacion, @PathVariable Integer type) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        appLogs = new AppLogs(new Date(), "/api/document/validation/" + codigoVerificacion, null, "downloadPDFFile", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        String pathFile = this.pathFileDocumento(codigoVerificacion, type);
        Path path = Paths.get(pathFile);
        byte[] pdfContents = null;
        try {
            pdfContents = Files.readAllBytes(path);
        } catch (IOException e) {
            System.out.println(e);
        }
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=" + codigoVerificacion + ".pdf");
        ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(pdfContents, headers, HttpStatus.OK);
        return responseEntity;
    }

    private String pathFileDocumento(String codigoVerificacion, Integer tipo) {
        RestTemplate restTemplate = new RestTemplate();
        Long oidDocumento = restTemplate.getForObject(appProps.getRpConsultarOid() + codigoVerificacion + "/tipo/" + tipo, Long.class);
        String pathFile = appProps.getOutputDir() + codigoVerificacion + ".pdf";
        File file = new File(pathFile);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            omegaUploader.streamFile(oidDocumento, fos, appProps.getDocUrl());
            fos.close();
        } catch (IOException e) {
            System.out.println(e);
            return null;
        }
        return pathFile;
    }

    @RequestMapping(value = "/movil/documento/{codigoVerificacion}/tipo/{type}", method = RequestMethod.GET)
    public List<ImagesCertificados> downloadPDFFileImage2(@PathVariable String codigoVerificacion, @PathVariable Integer type) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        appLogs = new AppLogs(new Date(), "/api/document/movil/" + codigoVerificacion, null, "downloadPDFFileImage", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        String pathFile = this.pathFileDocumento(codigoVerificacion, type);
        List<ImagesCertificados> files = new ArrayList<>();
        if (pathFile != null) {
            String fileName, tempName;
            BufferedImage bim;
            try (final PDDocument document = PDDocument.load(new File(pathFile))) {
                PDFRenderer pdfRenderer = new PDFRenderer(document);
                for (int page = 0; page < document.getNumberOfPages(); ++page) {
                    bim = pdfRenderer.renderImageWithDPI(page, 500, ImageType.RGB);
                    tempName = codigoVerificacion + "-" + page + ".png";
                    fileName = appProps.getOutputDir() + tempName;
                    files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + tempName));
                    ImageIOUtil.writeImage(bim, fileName, 500);
                }
                document.close();
            } catch (IOException e) {
                files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + " sin_resultados.png"));
                System.err.println("Exception while trying to create pdf document - " + e);
            }
        } else {
            files.add(new ImagesCertificados(appProps.getUrlPdfFirmado() + " sin_resultados.png"));
        }
        return files;
    }

}
