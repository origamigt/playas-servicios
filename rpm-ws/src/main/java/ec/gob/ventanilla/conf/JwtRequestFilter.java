package ec.gob.ventanilla.conf;


import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ec.gob.ventanilla.security.JwtUserDetailsService;
import ec.gob.ventanilla.util.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;


import io.jsonwebtoken.ExpiredJwtException;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUserDetailsService jwtUserDetailsService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {

        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Authorization, Content-Type, Accept, X-Requested-With, remember-me");
        System.out.println(request.getRequestURI());
        if (!request.getRequestURI().contains("/rpm-ventanilla/api/autentificacion")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/usuario/loginUser")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/actosInscricipciones")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/pagos/verificarPago")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/terminosCondicion")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/actosPopulares")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/usuario/actualizarContrasenia")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/usuario/activarUsuarioEntidad")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/correo/generarCodigoRegistro")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/correo/validarCodigoRegistro")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/actos/id/")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/usuario/consultar")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/requisitos/")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/documento/")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/solicitud/buscarTramite")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/solicitud/actualizarTramiteInscripcion")
                && !request.getRequestURI().contains("/rpm-ventanilla/api/solicitud/actualizarSolicitudObservacion")
                && !request.getRequestURI().startsWith("/api/solicitud/registrarInscripcion")
                && !request.getRequestURI().startsWith("/api/solicitud/actualizarTramiteInscripcion")
                && !request.getRequestURI().startsWith("/api/solicitud/buscarTramite")
        ) {
            final String requestTokenHeader = request.getHeader("Authorization");
            String username = null;
            String jwtToken = null;
// JWT Token is in the form "Bearer token". Remove Bearer word and get
// only the Token
            if (requestTokenHeader != null && requestTokenHeader.startsWith("Bearer")) {
                jwtToken = requestTokenHeader.substring(7);
                try {
                    username = jwtTokenUtil.getUsernameFromToken(jwtToken);
                } catch (IllegalArgumentException e) {
                    System.out.println("Unable to get JWT Token");
                } catch (ExpiredJwtException e) {
                    System.out.println("JWT Token has expired");
                }
            } else {
                logger.warn("JWT Token does not begin with Bearer String");
            }

// Once we get the token validate it.
            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

                UserDetails userDetails = this.jwtUserDetailsService.loadUserByUsername(username);

// if token is valid configure Spring Security to manually set
// authentication
                if (jwtTokenUtil.validateToken(jwtToken, userDetails)) {

                    UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities());
                    usernamePasswordAuthenticationToken
                            .setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
// After setting the Authentication in the context, we specify
// that the current user is authenticated. So it passes the
// Spring Security Configurations successfully.
                    SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
                    chain.doFilter(request, response);
                }

            }
        } else {
            chain.doFilter(request, response);
        }
    }

}