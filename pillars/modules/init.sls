modules:
  backend:
    config:
      app:
        baseUrl:
          type: String
          default: localhost
          envName: APP_BASE_URL 
          optional: false
        title:
          type: String
          default: ktorbase
          envName: APP_TITLE
          optional: true
        bannerBackgroundColor:
          type: String
          default: 'rgba(0, 0, 50, 0.5)'
          envName: APP_BANNER_BACKGROUND_COLOR 
          optional: true
        bannerMenuBackgroundColor:
          type: String
          default: 'rgba(0, 0, 50, 0.6)'
          envName: APP_BANNER_MENU_BACKGROUND_COLOR 
          optional: true
        ssoSaml:
          type: Boolean
          default: false
          envName: APP_SSO_SAML
          optional: true

      session:
        expiration:
          type: String
          default: 7d
          envName: SESSION_EXPIRATION
          optional: true

      saml:
        identityProvider:
          entityId:
            type: String
            default: ''
            envName: SAML_IDENTITY_PROVIDER_ENTITY_ID
            optional: false
          loginUrl:
            type: String
            default: ''
            envName: SAML_IDENTITY_PROVIDER_LOGIN_URL
            optional: false
          logoutUrl:
            type: String
            default: ''
            envName: SAML_IDENTITY_PROVIDER_LOGOUT_URL
            optional: false
          certificate:
            type: String
            default: ''
            envName: SAML_IDENTITY_PROVIDER_CERTIFICATE
            optional: false

        serviceProvider:
          samlBaseUrl:
            type: String
            default: '${app.baseUrl}/sso/saml'
            envName: SAML_SERVICE_PROVIDER_BASE_URL
            optional: true
          nameIdFormat :
            type: String
            default: "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
            envName: SAML_SERVICE_PROVIDER_NAME_ID_FORMAT
            optional: true
          organizationName:
            type: String
            default: 'linked-planet GmbH'
            envName: SAML_SERVICE_PROVIDER_ORGANIZATION_NAME
            optional: true
          organizationDisplayName:
            type: String
            default: 'linked-planet GmbH'
            envName: SAML_SERVICE_PROVIDER_ORGANIZATION_DISPLAY_NAME
            optional: true
          organizationUrl:
            type: String
            default: 'https://linked-planet.com'
            envName: SAML_SERVICE_PROVIDER_ORGANIZATION_URL
            optional: true
          organizationLang:
            type: String
            default: 'en'
            envName: SAML_SERVICE_PROVIDER_ORGANIZATION_LANG
            optional: true

    db:
      postgres:
        use: true
    ktor:
      version: 1.1.3
      server:
        use: true
        features:
          saml:
            selected: false
            configurable: false
            fileprefix: Saml
          defaultheaders:
            selected: true
            configurable: false
            fileprefix: DefaultHeaders
          calllogging:
            selected: true
            configurable: false
            fileprefix: CallLogging
          conditionalheaders:
            selected: true
            configurable: false
            fileprefix: ConditionalHeaders
          compression:
            selected: true
            configurable: false
            fileprefix: Compression
          locations:
            selected: true
            configurable: false
            fileprefix: Locations
          xforwardedheadersupport:
            selected: true
            configurable: false
            fileprefix: XForwardedHeaderSupport
          sessions:
            selected: false
            configurable: true
            fileprefix: Sessions
          statuspages:
            selected: true
            configurable: true
            fileprefix: StatusPages
          authentication:
            selected: true
            configurable: true
            fileprefix: Authentication
          contentnegotiation:
            selected: true
            configurable: true
            fileprefix: ContentNegotiation
      client:
        use: true
    gateways:
      - jira
      - confluence
      - insight
  frontend:
    use: true
  test:
    jmeter:
      use: true


