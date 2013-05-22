# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-9999.ebuild,v 1.44 2012/10/21 12:00:16 ssuominen Exp $

EAPI=5
VALA_MIN_API_VERSION=0.18

PYTHON_COMPAT=( python2_7 )

inherit eutils fdo-mime gnome2-utils python-any-r1 waf-utils vala bzr

DESCRIPTION="A lightweight web browser based on WebKitGTK+"
HOMEPAGE="http://twotoasts.de/index.php/midori/"
EBZR_REPO_URI="lp:midori"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS=""
IUSE="+deprecated doc gnome libnotify nls +unique webkit2 zeitgeist"

RDEPEND=">=dev-db/sqlite-3.6.19:3
	>=dev-libs/glib-2.22
	dev-libs/libxml2
	>=net-libs/libsoup-2.34:2.4
	x11-libs/libXScrnSaver
	>=app-crypt/gcr-3
	>=net-libs/webkit-gtk-1.10.2:3
	x11-libs/gtk+:3
	x11-libs/granite
	unique? ( dev-libs/libunique:3 )
	gnome? ( || ( >=net-libs/libsoup-2.42:2.4 >=net-libs/libsoup-gnome-2.34:2.4 ) )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.14 )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	$(vala_depend)
	dev-util/intltool
	gnome-base/librsvg
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python-any-r1_pkg_setup

	DOCS=( AUTHORS ChangeLog HACKING INSTALL TODO TRANSLATE )
	HTML_DOCS=( data/faq.html data/faq.css )
}

src_prepare() {
	# Force disabled because we don't have this custom renamed in Portage
	sed -i -e 's:gcr-3-gtk2:&dIsAbLe:' wscript || die

	vala_src_prepare
}

src_configure() {
	strip-linguas -i po

	waf-utils_src_configure \
		--disable-docs \
		$(use_enable doc apidocs) \
		$(use_enable unique) \
		$(use_enable libnotify) \
		$(use_enable webkit2) \
		$(use_enable zeitgeist) \
		--enable-addons \
		$(use_enable nls) \
		--enable-gtk3
		--enable-granite
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
