package backend;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    // Paths that can be accessed without authentication
    private static final String[] PUBLIC_PATHS = {
            "/login", "/login.jsp", "/registration", "/registration.jsp", "/css/", "/js/", "/images/", "/favicon.ico", "/meals-plans.html"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Check if the requested path is public
        boolean isPublicResource = false;
        for (String path : PUBLIC_PATHS) {
            if (requestPath.equals(path) || requestPath.startsWith(path)) {
                isPublicResource = true;
                break;
            }
        }

        // Check if user is authenticated or accessing a public resource
        boolean isAuthenticated = (session != null && session.getAttribute("userID") != null);

        if (isAuthenticated || isPublicResource) {
            // User is authenticated or accessing public resource, proceed with request
            chain.doFilter(request, response);
        } else {
            // User is not authenticated and trying to access protected resource
            // Redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}