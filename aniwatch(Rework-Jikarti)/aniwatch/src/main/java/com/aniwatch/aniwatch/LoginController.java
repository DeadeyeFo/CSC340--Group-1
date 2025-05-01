package com.aniwatch.aniwatch;

import com.aniwatch.aniwatch.user.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @GetMapping("/login")
    public String loginPage(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "registered", required = false) String registered) {

        // Create a one-time modal display
        return "redirect:/?showLoginModal=true" +
                (error != null ? "&loginError=true" : "") +
                (registered != null ? "&registered=true" : "");
    }

    @PostMapping("/login")
    public String processLogin(
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        try {
            // Check if adminLoginError parameter should be passed
            String loginType = request.getParameter("loginType");
            String username = request.getParameter("username");

            if ("admin".equals(loginType)) {
                // Check if user exists and has admin role
                User user = userRepository.findByUsername(username).orElse(null);

                if (user == null || !user.getRoles().contains("ADMIN")) {
                    redirectAttributes.addFlashAttribute("adminLoginError", true);
                    return "redirect:/?showLoginModal=true&adminLoginError=true";
                }
            }

            // Spring Security will process the login
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("loginError", true);
            return "redirect:/?showLoginModal=true&loginError=true";
        }
    }

    // Redirects to home upon error
    @GetMapping("/login-error")
    public String loginError() {
        return "redirect:/?showLoginModal=true&loginError=true";
    }

    @GetMapping("/login-success")
    public String loginSuccess() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth != null && auth.isAuthenticated()) {
            boolean isAdmin = auth.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

            if (isAdmin) {
                return "redirect:/admin";
            }
        }

        return "redirect:/home";
    }

    // Debug endpoint to see all users in the database, will remove later
    @GetMapping("/debug/users")
    public String debugUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "debug-users";
    }

    // Checks if a username already exists (for AJAX validation)
    @GetMapping("/check-username")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkUsername(@RequestParam String username) {
        boolean exists = userRepository.findByUsername(username).isPresent();

        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);

        return ResponseEntity.ok(response);
    }
}