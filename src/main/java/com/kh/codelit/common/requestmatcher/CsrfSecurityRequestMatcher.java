package com.kh.codelit.common.requestmatcher;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.web.util.matcher.RegexRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

public class CsrfSecurityRequestMatcher implements RequestMatcher {
	
	/**
	 * See
	 *
	 * http://blogs.sourceallies.com/2014/04/customizing-csrf-protection-in-spring-security/
	 * https://docs.spring.io/spring-security/site/docs/current/reference/html/appendix-namespace.html#nsa-csrf
	 *
	 *
	 */
	
	private Pattern allowedMethods = Pattern.compile("^(GET|HEAD|TRACE|OPTIONS)$");
    private RegexRequestMatcher dwrRequestMatcher = new RegexRequestMatcher("/dwr/.*\\.dwr", "POST");
    private RegexRequestMatcher restRequestMatcher = new RegexRequestMatcher("/rest/.*\\.view(\\?.*)?", "POST");

	@Override
	public boolean matches(HttpServletRequest request) {
		boolean requireCsrfToken = true;

        if(allowedMethods.matcher(request.getMethod()).matches()){
            requireCsrfToken = false;
        } else {
            if (dwrRequestMatcher.matches(request)) {
                requireCsrfToken = false;
            } else if (restRequestMatcher.matches(request)) {
                requireCsrfToken = false;
            }
        }

        return requireCsrfToken;
	}

}
