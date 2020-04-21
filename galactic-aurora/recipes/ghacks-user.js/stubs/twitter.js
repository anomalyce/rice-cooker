
/**
 * MEDIA
 */

// Set the homepage
user_pref("browser.startup.homepage", "https://twitter.com");

// Volume
user_pref("media.default_volume", 0.3);



/**
 * SECURITY
 */

// Enable `Fingerprinting`
user_pref("privacy.resistFingerprinting", true);

// Disable `Letterboxing`
user_pref("privacy.resistFingerprinting.letterboxing", false);

// Disable `WebGL`
user_pref("services.sync.prefs.sync.webgl.disabled", true);

// Disable `Pocket`
user_pref("extensions.pocket.enabled", false);

// Disable `Reader View`
user_pref("reader.parse-on-load.enabled", false);

// Disable `What's New`
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);

// Prevent sites from failing completely when the OCSP fails
user_pref("security.ssl.enable_ocsp_stapling", false);



/**
 * ACCESSIBILITY
 */

// Enable `Search Engines`
user_pref("keyword.enabled", true);

// Prevent having to hold right click for the context menu
user_pref("ui.context_menus.after_mouseup", true);

// HiDPI UI re-scaling
user_pref("layout.css.devPixelsPerPx", "1.4");

// Disable `Preferences: Privacy & Security > Logins and Passwords > Ask to save logins and passwords for websites`
user_pref("signon.rememberSignons", false);

// Disable `Preferences: Privacy & Securiy > History > Settings > History`
user_pref("privacy.clearOnShutdown.history", false);
user_pref("privacy.cpd.history", false);

// Disable `Preferences: Privacy & Security > History > Settings > Active Logins`
user_pref("privacy.clearOnShutdown.sessions", false);
user_pref("privacy.cpd.sessions", false);

// Disable `Preferences: Privacy & Security > History > Settings > Cookies`
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.cpd.cookies", false);

// Enable `Preferences: General > Startup > Restore Previous Session`
user_pref("browser.startup.page", 3);
user_pref("toolkit.winRegisterApplicationRestart", true);

// Enable Disk Cache for high-res videos & lots of tabs
user_pref("browser.cache.disk.enable", true);

// Sets `Preferences: Privacy & Security > Permissions > Autoplay` to `Block Audio and Video`
user_pref("media.autoplay.default", 5);



/**
 * DESIGN
 */

// Enable `userChrome.css`
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Theme MaterialFox
user_pref("svg.context-properties.content.enabled", true);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("materialFox.reduceTabOverflow", true);
user_pref("browser.tabs.tabClipWidth", 83);

