package ec.gob.ventanilla.security;

import ec.gob.ventanilla.conf.JwtRequestFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.savedrequest.NullRequestCache;
import org.springframework.session.web.http.HeaderHttpSessionStrategy;
import org.springframework.session.web.http.HttpSessionStrategy;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

    @Autowired
    private UserDetailsService jwtUserDetailsService;

    @Autowired
    private JwtRequestFilter jwtRequestFilter;

    @Bean
    public HttpSessionStrategy httpSessionStrategy() {
        return new HeaderHttpSessionStrategy();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(jwtUserDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new MD5PasswordEncoder();
    }

    @Bean(name = BeanIds.AUTHENTICATION_MANAGER)
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and().csrf().disable()
                .authorizeRequests()
                .antMatchers("/rpm-ventanilla/api/terminosCondicion").permitAll()
                .antMatchers("/rpm-ventanilla/api/autentificacion").permitAll()
                .antMatchers("/rpm-ventanilla/api/usuario/consultar").permitAll()
                .antMatchers("/rpm-ventanilla/api/usuario/actualizarContrasenia").permitAll()
                .antMatchers("/rpm-ventanilla/api/usuario/activarUsuarioEntidad").permitAll()
                .antMatchers("/rpm-ventanilla/api/usuario/consultar/recuperar").permitAll()
                .antMatchers("/rpm-ventanilla/api/actosInscricipciones").permitAll()
                .antMatchers("/rpm-ventanilla/api/actos/id/**").permitAll()
                .antMatchers("/rpm-ventanilla/api/actosPopulares").permitAll()
                .antMatchers("/rpm-ventanilla/api/requisitos/**").permitAll()
                .antMatchers("/rpm-ventanilla/api/correo/generarCodigoRegistro").permitAll()
                .antMatchers("/rpm-ventanilla/api/pagos/verificarPago").permitAll()
                .antMatchers("/rpm-ventanilla/api/correo/validarCodigoRegistro").permitAll()
                .antMatchers("/rpm-ventanilla/api/documento/**").permitAll()
                .antMatchers("/rpm-ventanilla/api/documento/codigo/**").permitAll()
                .antMatchers("/rpm-ventanilla/api/documento/verificarArchivo/**").permitAll()
                .antMatchers("/rpm-ventanilla/api/solicitud/actualizarSolicitudObservacion").permitAll()
                .antMatchers("/rpm-ventanilla/api/solicitud/buscarTramite").permitAll()
                .antMatchers("/rpm-ventanilla/api/solicitud/actualizarTramiteInscripcion").permitAll()



                .antMatchers("/ws/rpm-ventanilla/api/autentificacion").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/terminosCondicion").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/usuario/consultar").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/usuario/actualizarContrasenia").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/usuario/activarUsuarioEntidad").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/usuario/consultar/recuperar").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/actosInscricipciones").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/actos/id/**").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/actosPopulares").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/requisitos/**").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/correo/generarCodigoRegistro").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/pagos/verificarPago").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/correo/validarCodigoRegistro").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/documento/**").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/documento/codigo/**").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/solicitud/buscarTramite").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/solicitud/actualizarSolicitudObservacion").permitAll()
                .antMatchers("/ws/rpm-ventanilla/api/solicitud/actualizarTramiteInscripcion").permitAll()

                .anyRequest().authenticated().and()
                .httpBasic().realmName("Servicios Online").and().requestCache().requestCache(new NullRequestCache());
        http.addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
 


    }

}
