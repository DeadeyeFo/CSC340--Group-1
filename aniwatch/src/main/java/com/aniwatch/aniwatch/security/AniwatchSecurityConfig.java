package com.aniwatch.aniwatch.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class AniwatchSecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // Keeping CSRF disabled for debugging - they will use <#if _csrf??> temporarily
                .csrf(csrf -> csrf.disable())

                // Will Re-enable CSRF once everything works (big cope)
                // .csrf(csrf -> csrf.ignoringRequestMatchers("/register/**"))

                .authorizeHttpRequests(authorize -> authorize
                        // Static resources
                        .requestMatchers("/css/**", "/js/**", "/pics/**", "/uploads/**", "/images/**", "/favicon.ico").permitAll()

                        // Public pages
                        .requestMatchers("/", "/home").permitAll()
                        .requestMatchers("/register/**", "/login", "/logout").permitAll()
                        .requestMatchers("/debug/**").permitAll() // Debug endpoints
                        .requestMatchers("/watchlists/watchlist-list", "/watchlists/*").permitAll()
                        .requestMatchers("/comments/**").permitAll()
                        .requestMatchers("/browse-anime").permitAll()
                        .requestMatchers("/profile/select").permitAll()
                        .requestMatchers("/profile/new", "/profile/create").permitAll()

                        // Protected pages
                        .requestMatchers("/watchlists/new", "/watchlists/create").hasAuthority("ROLE_PROVIDER")
                        .requestMatchers("/provider-profile/**").authenticated()
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .failureHandler(authenticationFailureHandler())
                        .successHandler(authenticationSuccessHandler())
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/home")
                        .permitAll()
                );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        SimpleUrlAuthenticationFailureHandler handler = new SimpleUrlAuthenticationFailureHandler("/login?error=true");
        handler.setUseForward(false);
        return handler;
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            System.out.println("User successfully authenticated: " + authentication.getName());
            System.out.println("Authorities: " + authentication.getAuthorities());
            response.sendRedirect("/home");
        };
    }
}