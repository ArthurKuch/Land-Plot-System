package com.kuch.landsystem.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "EncodingFilter")
public class EncodingFilter implements Filter {
    private String encoding;


    public void destroy() {
        //-----------------
    }


    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {


        String requestEncoding = request.getCharacterEncoding();

        if (requestEncoding == null) {
            request.setCharacterEncoding(encoding);
        }

        chain.doFilter(request, response);
    }


    public void init(FilterConfig fConfig) {
        encoding = fConfig.getInitParameter("encoding");
    }
}
