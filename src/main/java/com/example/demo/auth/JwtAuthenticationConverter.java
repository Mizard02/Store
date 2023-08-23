package com.example.demo.auth;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.convert.converter.Converter;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtClaimNames;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class JwtAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken> {
    @Value("${jwt.auth.converter.resource-id}")
    private String CLIENT_NAME;

    @Value("${jwt.auth.converter.principle-attribute}")
    private String PRINCIPLE_ATTRIBUTE;

    private final JwtGrantedAuthoritiesConverter jwtGrantedAuthoritiesConverter = new JwtGrantedAuthoritiesConverter();
    @Override
    public AbstractAuthenticationToken convert(@NonNull Jwt source) {
        Collection<GrantedAuthority> authorities = Stream.concat(jwtGrantedAuthoritiesConverter.convert(source).stream(), extractResourceRoles(source).stream()).collect(Collectors.toSet());
        return new JwtAuthenticationToken(source, authorities, getPrincipleClaimName(source));
    }

    private Collection< ? extends GrantedAuthority> extractResourceRoles(Jwt jwt){
        if(jwt.getClaim("resource_access") == null)
            return null;
        Map<String, Object> resourceAccess = jwt.getClaim("resource_access");
        if(resourceAccess.get(CLIENT_NAME) == null)
            return null;
        Map<String, Object> resource = (Map<String, Object>) resourceAccess.get(CLIENT_NAME);
        Collection<String> resourceRoles = (Collection<String>) resource.get("roles");
        return resourceRoles.stream().map(role -> new SimpleGrantedAuthority(("ROLE_" + role))).collect(Collectors.toSet());
    }

    public String getPrincipleClaimName(Jwt jwt){
        String claimName = JwtClaimNames.SUB;
        if(PRINCIPLE_ATTRIBUTE != null)
            claimName = PRINCIPLE_ATTRIBUTE;
        return jwt.getClaim(claimName);
    }
}
