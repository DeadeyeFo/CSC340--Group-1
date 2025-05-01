<#macro authModals>
<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">Login</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="loginErrorAlert" class="alert alert-danger <#if loginError?? && loginError>d-block<#else>d-none</#if>">
          Invalid username or password.
        </div>
        <div id="adminLoginErrorAlert" class="alert alert-danger <#if adminLoginError?? && adminLoginError>d-block<#else>d-none</#if>">
          Admin credentials required. You do not have admin privileges.
        </div>
        <div id="registrationSuccessAlert" class="alert alert-success <#if registered?? && registered>d-block<#else>d-none</#if>">
          Registration successful! Please login.
        </div>
        <form id="loginForm" method="post" action="/login">
          <div class="mb-3">
            <label for="loginUsername" class="form-label">USERNAME</label>
            <input type="text" class="form-control" id="loginUsername" name="username" required>
          </div>
          <div class="mb-3">
            <label for="loginPassword" class="form-label">PASSWORD</label>
            <input type="password" class="form-control" id="loginPassword" name="password" required>
          </div>
          <div class="mb-4">
            <label class="form-label">LOGIN AS</label>
            <div class="d-flex gap-3">
              <div class="form-check">
                <input class="form-check-input" type="radio" name="loginType" id="loginTypeUser" value="user" checked>
                <label class="form-check-label" for="loginTypeUser">
                  Regular User
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input" type="radio" name="loginType" id="loginTypeAdmin" value="admin">
                <label class="form-check-label" for="loginTypeAdmin">
                  Admin
                </label>
              </div>
            </div>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary-modal">Login</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <p>Don't have an account?</p>
        <div class="registration-options">
          <button class="registration-option switch-to-user-register">Register as User</button>
          <button class="registration-option switch-to-provider-register">Register as Provider</button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- User Registration Modal -->
<div class="modal fade" id="userRegisterModal" tabindex="-1" aria-labelledby="userRegisterModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="userRegisterModalLabel">Create User Account</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="userRegisterErrorAlert" class="alert alert-danger <#if registerErrorMessage?? && showUserRegisterModal??>d-block<#else>d-none</#if>">
          ${registerErrorMessage!'Error message will appear here'}
        </div>
        <form id="userRegisterForm" method="post" action="/register/user">
          <div class="mb-3">
            <label for="userRegisterUsername" class="form-label">USERNAME</label>
            <input type="text" class="form-control" id="userRegisterUsername" name="username" required>
          </div>
          <div class="mb-3">
            <label for="userRegisterPassword" class="form-label">PASSWORD</label>
            <input type="password" class="form-control" id="userRegisterPassword" name="password" required>
            <div class="form-text">Password must be at least 8 characters long</div>
          </div>
          <div class="mb-4">
            <label for="userRegisterConfirmPassword" class="form-label">CONFIRM PASSWORD</label>
            <input type="password" class="form-control" id="userRegisterConfirmPassword" name="confirmPassword" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary-modal">Create Account</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <p>Already have an account? <a href="#" class="switch-to-login">Login</a></p>
      </div>
    </div>
  </div>
</div>

<!-- Provider Registration Modal -->
<div class="modal fade" id="providerRegisterModal" tabindex="-1" aria-labelledby="providerRegisterModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="providerRegisterModalLabel">Create Provider Account</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="providerRegisterErrorAlert" class="alert alert-danger <#if registerErrorMessage?? && showProviderRegisterModal??>d-block<#else>d-none</#if>">
          ${registerErrorMessage!'Error message will appear here'}
        </div>
        <form id="providerRegisterForm" method="post" action="/register/provider" enctype="multipart/form-data">
          <div class="mb-3">
            <label for="providerRegisterUsername" class="form-label">USERNAME</label>
            <input type="text" class="form-control" id="providerRegisterUsername" name="providerUsername" required>
          </div>
          <div class="mb-3">
            <label for="providerRegisterEmail" class="form-label">EMAIL ADDRESS</label>
            <input type="email" class="form-control" id="providerRegisterEmail" name="providerEmail" required>
          </div>
          <div class="mb-3">
            <label for="providerRegisterPassword" class="form-label">PASSWORD</label>
            <input type="password" class="form-control" id="providerRegisterPassword" name="password" required>
            <div class="form-text">Password must be at least 8 characters long</div>
          </div>
          <div class="mb-4">
            <label for="providerRegisterConfirmPassword" class="form-label">CONFIRM PASSWORD</label>
            <input type="password" class="form-control" id="providerRegisterConfirmPassword" name="confirmPassword" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary-modal">Create Provider Account</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <p>Already have an account? <a href="#" class="switch-to-login">Login</a></p>
      </div>
    </div>
  </div>
</div>

<!-- Auth modals CSS -->
<style>
        .modal-content {
          background-color: #1a1a1a!important;
          border: none!important;
          border-radius: 10px!important;
          box-shadow: 0 0 30px rgba(0, 0, 0, 0.6)!important;
        }

        .modal-header, .modal-footer {
          border: none!important;
          padding: 20px 24px!important;
        }

        .modal-header .modal-title {
          font-size: 24px!important;
          font-weight: 600!important;
          color: #fff!important;
        }

        .modal-body {
          padding: 20px 24px!important;
        }

        .form-label {
          font-size: 14px!important;
          font-weight: 500!important;
          color: #aaa!important;
          text-transform: uppercase!important;
          letter-spacing: 1px!important;
          margin-bottom: 8px!important;
        }

        .form-control {
              border: none!important;
              border-radius: 6px!important;
              font-size: 16px!important;
              padding: 12px 16px!important;
              height: auto!important;
            }

            .form-control:focus {
              box-shadow: 0 0 0 3px rgba(79, 166, 255, 0.25)!important;
            }

        .form-check-label {
          font-size: 16px!important;
          color: #fff!important;
          text-transform: none!important;
          letter-spacing: normal!important;
        }

        .form-text {
            margin-top: .25rem!important;
            font-size: .8em!important;
            color: white!important;
        }

        .btn-primary-modal {
          background: linear-gradient(135deg, #4299e1, #3182ce)!important;
          border: none!important;
          border-radius: 6px!important;
          color: white!important;
          font-weight: 600!important;
          padding: 12px 0!important;
          transition: all 0.2s!important;
          margin: 0px!important;
        }

        .btn-primary-modal:hover {
          background: linear-gradient(135deg, #3182ce, #2b6cb0)!important;
          transform: translateY(-1px)!important;
        }

        .modal-footer {
          justify-content: center!important;
          background-color: #1a1a1a!important;
        }

        .modal-footer a {
          color: #4299e1!important;
          text-decoration: none!important;
        }

        .modal-footer a:hover {
          text-decoration: underline!important;
        }

        /* Registration options */
        .registration-options {
          display: flex!important;
          gap: 10px!important;
          justify-content: center!important;
          margin-top: 10px!important;
          flex-wrap: wrap!important;
        }

        .registration-option {
          background-color: #2c2c2c!important;
          border: none!important;
          border-radius: 6px!important;
          color: #fff!important;
          font-weight: 500!important;
          padding: 10px 16px!important;
          transition: all 0.2s!important;
        }

        .registration-option:hover {
          background-color: #3a3a3a!important;
        }

        .alert {
          border-radius: 6px;
          padding: 12px 16px;
          margin-bottom: 20px;
        }

        .btn-close-white {
          filter: invert(1) grayscale(100%) brightness(200%);
        }
</style>

<!-- Auth modals JavaScript -->
<script>
document.addEventListener('DOMContentLoaded', function() {
  // Get references to modal elements
  const loginModal = document.getElementById('loginModal');
  const userRegisterModal = document.getElementById('userRegisterModal');
  const providerRegisterModal = document.getElementById('providerRegisterModal');

  // Get references to modal instances
  let loginModalInstance, userRegisterModalInstance, providerRegisterModalInstance;

  if (loginModal) {
    loginModalInstance = new bootstrap.Modal(loginModal);

    // Check if login modal should be shown based on URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const showLoginModal = urlParams.get('showLoginModal');
    const loginError = urlParams.get('loginError');
    const adminLoginError = urlParams.get('adminLoginError');
    const registered = urlParams.get('registered');

    if (showLoginModal === 'true' || loginError || adminLoginError || registered) {
      loginModalInstance.show();
    }

    // Handle login form submission with client-side validation
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
      loginForm.addEventListener('submit', function(event) {
        const username = document.getElementById('loginUsername').value;
        const password = document.getElementById('loginPassword').value;
        const loginTypeAdmin = document.getElementById('loginTypeAdmin').checked;
        const errorAlert = document.getElementById('loginErrorAlert');
        const adminErrorAlert = document.getElementById('adminLoginErrorAlert');

        errorAlert.classList.add('d-none');
        adminErrorAlert.classList.add('d-none');

        if (!username || !password) {
          event.preventDefault();
          errorAlert.textContent = 'All fields are required.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        return true; // Proceed with form submission
      });
    }
  }

  if (userRegisterModal) {
    userRegisterModalInstance = new bootstrap.Modal(userRegisterModal);

    // Handle user registration form validation
    const userRegisterForm = document.getElementById('userRegisterForm');
    if (userRegisterForm) {
      userRegisterForm.addEventListener('submit', function(event) {
        const password = document.getElementById('userRegisterPassword').value;
        const confirmPassword = document.getElementById('userRegisterConfirmPassword').value;
        const errorAlert = document.getElementById('userRegisterErrorAlert');

        // Reset error message
        errorAlert.classList.add('d-none');

        // Validate password length
        if (password.length < 8) {
          event.preventDefault();
          errorAlert.textContent = 'Password must be at least 8 characters long.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        // Validate password match
        if (password !== confirmPassword) {
          event.preventDefault();
          errorAlert.textContent = 'Passwords do not match.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        // All validations passed
        return true;
      });
    }
  }

  if (providerRegisterModal) {
    providerRegisterModalInstance = new bootstrap.Modal(providerRegisterModal);

    const providerRegisterForm = document.getElementById('providerRegisterForm');
    if (providerRegisterForm) {
      providerRegisterForm.addEventListener('submit', function(event) {
        const password = document.getElementById('providerRegisterPassword').value;
        const confirmPassword = document.getElementById('providerRegisterConfirmPassword').value;
        const errorAlert = document.getElementById('providerRegisterErrorAlert');

        errorAlert.classList.add('d-none');

        if (password.length < 8) {
          event.preventDefault();
          errorAlert.textContent = 'Password must be at least 8 characters long.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        if (password !== confirmPassword) {
          event.preventDefault();
          errorAlert.textContent = 'Passwords do not match.';
          errorAlert.classList.remove('d-none');
          return false;
        }

        return true;
      });
    }
  }

  // Handle switching from login to user registration
  const switchToUserRegisterButtons = document.querySelectorAll('.switch-to-user-register');
  switchToUserRegisterButtons.forEach(button => {
    button.addEventListener('click', function() {
      if (loginModalInstance) loginModalInstance.hide();
      if (userRegisterModalInstance) setTimeout(() => userRegisterModalInstance.show(), 500);
    });
  });

  // Handle switching from login to provider registration
  const switchToProviderRegisterButtons = document.querySelectorAll('.switch-to-provider-register');
  switchToProviderRegisterButtons.forEach(button => {
    button.addEventListener('click', function() {
      if (loginModalInstance) loginModalInstance.hide();
      if (providerRegisterModalInstance) setTimeout(() => providerRegisterModalInstance.show(), 500);
    });
  });

  // Handle switching from registration back to login
  const switchToLoginButtons = document.querySelectorAll('.switch-to-login');
  switchToLoginButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      if (userRegisterModalInstance) userRegisterModalInstance.hide();
      if (providerRegisterModalInstance) providerRegisterModalInstance.hide();
      if (loginModalInstance) setTimeout(() => loginModalInstance.show(), 500);
    });
  });

  // Update the navigation login link to show the modal instead of navigating
  const loginLinks = document.querySelectorAll('a[href="/login"], a[href="/login.html"]');
  loginLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      if (loginModalInstance) {
        // Select regular user login by default
        document.getElementById('loginTypeUser').checked = true;
        loginModalInstance.show();
      }
    });
  });

  // Update admin login link to show login modal with admin option pre-selected
  const adminLoginLinks = document.querySelectorAll('a[href="/admin/login"], a[href="/admin"]');
  adminLoginLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      if (loginModalInstance) {
        document.getElementById('loginTypeAdmin').checked = true;
        loginModalInstance.show();
      }
    });
  });

  // Clean URL parameters to prevent the modal from reopening
  function cleanUrlParameters() {
    const url = new URL(window.location.href);
    const paramsToRemove = ['showLoginModal', 'loginError', 'registered', 'adminLoginError'];

    let shouldUpdate = false;
    paramsToRemove.forEach(param => {
      if (url.searchParams.has(param)) {
        url.searchParams.delete(param);
        shouldUpdate = true;
      }
    });

    if (shouldUpdate) {
      window.history.replaceState({}, document.title, url.toString());
    }
  }

  cleanUrlParameters();

  // Clear form data and errors when modals are closed
  if (loginModal) {
    loginModal.addEventListener('hidden.bs.modal', function() {
      const loginErrorAlert = document.getElementById('loginErrorAlert');
      const adminLoginErrorAlert = document.getElementById('adminLoginErrorAlert');
      const registrationSuccessAlert = document.getElementById('registrationSuccessAlert');

      if (loginErrorAlert) loginErrorAlert.classList.add('d-none');
      if (adminLoginErrorAlert) adminLoginErrorAlert.classList.add('d-none');
      if (registrationSuccessAlert) registrationSuccessAlert.classList.add('d-none');

      const usernameField = document.getElementById('loginUsername');
      const passwordField = document.getElementById('loginPassword');
      const loginTypeUser = document.getElementById('loginTypeUser');

      if (usernameField) usernameField.value = '';
      if (passwordField) passwordField.value = '';
      if (loginTypeUser) loginTypeUser.checked = true;
    });
  }
});
</script>
</#macro>