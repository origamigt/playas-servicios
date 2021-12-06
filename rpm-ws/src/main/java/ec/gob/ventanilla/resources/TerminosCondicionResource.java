package ec.gob.ventanilla.resources;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class TerminosCondicionResource {

    @RequestMapping(method = RequestMethod.GET, value = "terminosCondicion")
    public ResponseEntity<String> terminosCondiciones() {
        
        String body = "  <h1>\n"
                + "                    Términos y Condiciones de Uso\n"
                + "                </h1>\n"
                + "                \n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    Los siguientes términos y condiciones rigen el uso que usted le dé al sitio web y a la aplicación móvil \n"
                + "                    del Registro Municipal de la Propiedad y Mercantil Cantón Playas, \n"
                + "                    a cualquiera de los contenidos disponibles mediante este sitio web y aplicativo móvil. \n"
                + "                </h4>\n"
                + "                \n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    El Registro Municipal de la Propiedad y Mercantil Cantón Playas, puede cambiar los Términos y Condiciones en cualquier \n"
                + "                    momento sin ninguna notificación particular, únicamente publicando los cambios en el sitio web o móvil. \n"
                + "                </h4>\n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    AL USAR EL SITIO WEB Y/O NUESTRA APLICACIÓN MÓVIL, USTED ACEPTA Y ESTÁ DE ACUERDO CON ESTOS TÉRMINOS Y CONDICIONES. Si usted no está de acuerdo con estos Términos y Condiciones, \n"
                + "                    no puede tener acceso al mismo ni usar el Sitio Web y la Aplicación Móvil de ninguna otra manera.\n"
                + "                <br></br> En caso de presentar algun inconveniente reportar al siguiente correo: <b> tramites.registro.playas@gmail.com "
                + "                </h4>\n"
                + "                \n"
                + "                <h3 style=\"padding-left: 10px\">\n"
                + "                    1.\tSERVICIOS EN LINEA:\n"
                + "                </h3>\n"
                + "                \n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    El servicio ofrecido mediante el Sitio Web y Aplicación Móvil \n"
                + "                    es exclusivamente para las solicitudes de <b>\"CERTIFICADOS REGISTRALES E INSCRIPCIONES EN LÍNEA\".</b>\n"
                + "                </h4>\n"
                + "                <h3 style=\"padding-left: 10px\">\n"
                + "                    2.\tRESPONSABILIDAD\n"
                + "                </h3>\n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    En caso de usar un número de indentificación de otra persona y reporte inconvenientes será cancelada. <br></br>"
                + "                      \n La información proporcionada en las solicitudes realizadas por el usuario es de absoluta responsabilidad \n"
                + "                    de quien las ingresa. \n"
                + "                    Por lo que el Registro Municipal de la Propiedad y Mercantil Cantón Playas no se responsabiliza por "
                + "la información brindada.   \n"
                + "                </h4>   \n"
                + "                <h3 style=\"padding-left: 10px\">\n"
                + "                    3.\tFORMAS DE PAGO\n"
                + "                </h3>\n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    El Sitio Web y la Aplicación Móvil permiten realizar tres formas de pago:                    \n"
                + "                </h4>\n"
                + "                <h4 style=\"padding-left: 50px\">\n"
                + "                    * Ventanilla Del Registro <p></p>\n"
                + "                    * Transferencias bancarias <p></p>\n"
                + "                    * Pago En Línea\n"
                + "                </h4>\n"
                + "                <h3 style=\"padding-left: 10px\">\n"
                + "                    VENTANILLA DEL REGISTRO:\n"
                + "                </h3>\n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    En esta forma de pago se genera un número de trámite que es enviado al correo electrónico del solicitante, con el que el usuario se debe acercar a las ventanillas \n"
                + "                    de recaudación del Registro Municipal de la Propiedad y Mercantil Cantón Playas, a cancelar el valor correspondiente.\n"
                + "                </h4>\n"
                + "                <h3 style=\"padding-left: 10px\">\n"
                + "                    PAGOS EN LINEA\n"
                + "                </h3>\n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    Las tarjetas permitidas son Crédito y Débito: MasterCard y VISA de cualquier entidad bancaria. El pago no podrá ser diferido.\n"
                + "                    Cada transacción tendrá un valor adicional de $0.50 "
                + "centavos que representa el costo establecido por la institución financiera a la que pertenece la \n"
                + "                    Tarjeta con la que se realiza el pago. (Monto que no ingresa al Registro).\n"
                + "                    En caso de pérdida de la tarjeta bancaria el Registro Municipal de la Propiedad y Mercantil Cantón Playas no asume responsabilidad alguna.\n"
                + "                </h4>\n"
                + "                <h3 style=\"padding-left: 10px\">\n"
                + "                    3.1. DESCUENTOS\n"
                + "                </h3>\n"
                + "                <h4 style=\"padding-left: 30px\">\n"
                + "                    Los descuentos se aplicarán únicamente \n"
                + "                    a los pagos que se realicen mediante la opción pago en “VENTANILLA DEL REGISTRO” es decir, los pagos realizados mediante TARJETA NO APLICAN DESCUENTOS, \n"
                + "                    por ser pagos directos y la imposibilidad de verificar la información.     \n"
                + "                </h4>\n";
        return new ResponseEntity<>(body, HttpStatus.OK);
    }

}
