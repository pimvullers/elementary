# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-9999.ebuild,v 1.44 2012/10/21 12:00:16 ssuominen Exp $

EAPI=4

inherit eutils fdo-mime gnome2-utils python waf-utils git-2

VALA_VERSION=0.18

DESCRIPTION="A lightweight web browser based on WebKitGTK+"
HOMEPAGE="http://twotoasts.de/index.php/midori/"
EGIT_REPO_URI="git://git.xfce.org/apps/${PN}"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc gnome libnotify nls +unique zeitgeist"

RDEPEND=">=dev-db/sqlite-3.6.19:3
	>=dev-libs/glib-2.22
	dev-libs/libxml2
	>=net-libs/libsoup-2.34:2.4
	x11-libs/libXScrnSaver
	>=app-crypt/gcr-3
	net-libs/webkit-gtk:3
	x11-libs/gtk+:3
	x11-libs/granite
	unique? ( dev-libs/libunique:3 )
	gnome? ( >=net-libs/libsoup-gnome-2.34:2.4 )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.14 )"
DEPEND="${RDEPEND}
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	dev-lang/vala:${VALA_VERSION}
	dev-util/intltool
	gnome-base/librsvg
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	DOCS=( AUTHORS ChangeLog HACKING INSTALL TODO TRANSLATE )
	HTML_DOCS=( data/faq.html data/faq.css )
}

src_configure() {
	strip-linguas -i po

	VALAC="$(type -P valac-${VALA_VERSION})" \
	waf-utils_src_configure \
		--disable-docs \
		 $(use_enable doc apidocs) \
		 $(use_enable unique) \
		 $(use_enable libnotify) \
		 $(use_enable zeitgeist) \
		--enable-addons \
		$(use_enable nls) \
		--enable-gtk3
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
