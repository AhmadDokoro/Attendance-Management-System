package Utils;

import javax.servlet.http.HttpServletRequest;

/**
 * Utilities for building public (client-reachable) URLs.
 *
 * Reverse proxies (Render, Nginx, etc.) often terminate TLS and forward requests
 * to the app over plain HTTP. In those cases the app must prefer forwarded
 * headers to generate URLs that clients can actually open.
 */
public final class PublicUrlUtil {

    private PublicUrlUtil() {
    }

    /**
     * Returns the public base URL (scheme + host + optional port) to reach this app.
     *
     * Order of precedence:
     * 1) PUBLIC_BASE_URL env var (recommended for hosted deployments)
     * 2) X-Forwarded-* headers
     * 3) request.getScheme()/getServerName()/getServerPort()
     */
    public static String getPublicBaseUrl(HttpServletRequest request) {
        String env = trimToNull(System.getenv("PUBLIC_BASE_URL"));
        if (env != null) {
            return stripTrailingSlash(env);
        }

        // Try standard reverse-proxy headers
        String forwardedProto = firstHeaderValue(request.getHeader("X-Forwarded-Proto"));
        String forwardedHost = firstHeaderValue(request.getHeader("X-Forwarded-Host"));
        String forwardedPort = firstHeaderValue(request.getHeader("X-Forwarded-Port"));

        // Some proxies use this.
        if (forwardedProto == null) {
            String forwardedSsl = trimToNull(request.getHeader("X-Forwarded-Ssl"));
            if ("on".equalsIgnoreCase(forwardedSsl)) {
                forwardedProto = "https";
            }
        }

        String scheme = trimToNull(forwardedProto);
        if (scheme == null) {
            scheme = request.getScheme();
        }

        // forwardedHost can be "example.com" or "example.com:443"
        String host = trimToNull(forwardedHost);
        String port = trimToNull(forwardedPort);

        if (host == null) {
            host = request.getServerName();
            int p = request.getServerPort();
            port = String.valueOf(p);
        }

        // If host already includes port, trust it and ignore forwardedPort.
        if (host.contains(":")) {
            return stripTrailingSlash(scheme + "://" + host);
        }

        boolean includePort = shouldIncludePort(scheme, port);
        if (includePort) {
            return stripTrailingSlash(scheme + "://" + host + ":" + port);
        }
        return stripTrailingSlash(scheme + "://" + host);
    }

    /**
     * Builds a public URL for a given path (and optional query) inside this webapp.
     * Example relativePath: "/Student/ScanAttendance.jsp?x=1" (leading slash preferred)
     */
    public static String buildPublicUrl(HttpServletRequest request, String relativePath) {
        String base = getPublicBaseUrl(request);
        String ctx = request.getContextPath();
        if (ctx == null) ctx = "";

        String path = relativePath == null ? "" : relativePath.trim();
        if (!path.isEmpty() && !path.startsWith("/")) {
            path = "/" + path;
        }

        // ctx is "" or "/app". Ensure it doesn't end with '/'.
        if (!ctx.isEmpty() && ctx.endsWith("/")) {
            ctx = ctx.substring(0, ctx.length() - 1);
        }

        return base + ctx + path;
    }

    private static boolean shouldIncludePort(String scheme, String port) {
        if (port == null) return false;
        if (scheme == null) return true;
        if ("http".equalsIgnoreCase(scheme) && "80".equals(port)) return false;
        if ("https".equalsIgnoreCase(scheme) && "443".equals(port)) return false;
        return true;
    }

    private static String stripTrailingSlash(String s) {
        if (s == null) return null;
        while (s.endsWith("/")) {
            s = s.substring(0, s.length() - 1);
        }
        return s;
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    /**
     * For comma-separated header values, return first value.
     */
    private static String firstHeaderValue(String headerValue) {
        String v = trimToNull(headerValue);
        if (v == null) return null;
        int comma = v.indexOf(',');
        if (comma >= 0) {
            v = v.substring(0, comma).trim();
        }
        return v.isEmpty() ? null : v;
    }
}
