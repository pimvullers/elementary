diff -Naur portals-7.0.0_orig/data/meson.build portals-7.0.0/data/meson.build
--- portals-7.0.0_orig/data/meson.build	2023-02-28 18:36:56.378632989 +0100
+++ portals-7.0.0/data/meson.build	2023-02-28 18:37:27.768635142 +0100
@@ -11,19 +11,6 @@
     install_dir: datadir / 'dbus-1' / 'services'
 )
 
-systemduserunitdir = get_option('systemduserunitdir')
-if systemduserunitdir == ''
-    systemduserunitdir = systemd_dep.get_variable('systemduserunitdir', pkgconfig_define: [ 'prefix', prefix ])
-endif
-
-configure_file(
-    input: meson.project_name() + '.service.in',
-    output: '@BASENAME@',
-    configuration: conf_data,
-    install: true,
-    install_dir: systemduserunitdir
-)
-
 i18n.merge_file(
     input: 'portals.metainfo.xml.in',
     output: 'io.elementary.portals.metainfo.xml',
diff -Naur portals-7.0.0_orig/meson.build portals-7.0.0/meson.build
--- portals-7.0.0_orig/meson.build	2023-02-28 18:36:56.378632989 +0100
+++ portals-7.0.0/meson.build	2023-02-28 18:37:08.658633835 +0100
@@ -7,8 +7,6 @@
 libexecdir = prefix / get_option('libexecdir')
 localedir = prefix / get_option('localedir')
 
-systemd_dep = dependency('systemd')
-
 glib_dep = dependency('glib-2.0')
 gobject_dep = dependency('gobject-2.0')
 gio_dep = dependency('gio-2.0')
