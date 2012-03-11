# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils waf-utils git

DESCRIPTION="A super sexy, ultra simple desktop mail client"
HOMEPAGE="https://launchpad.net/postler"
EGIT_REPO_URI="git://git.xfce.org/apps/postler"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="addressbook calendar html ayatana"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.26:2
	dev-libs/libgee
	dev-libs/openssl
	mail-mta/msmtp
	media-libs/libcanberra
	|| ( ( >=x11-libs/gtk+-2.18:2 net-libs/webkit-gtk:2 )
		( x11-libs/gtk+:3 net-libs/webkit-gtk:3 ) )
	x11-libs/libnotify
	ayatana? ( dev-libs/libindicate )
	addressbook? ( app-office/dexter )
 	html? ( www-client/lynx )"
DEPEND="${RDEPEND}
	|| ( 
		dev-lang/python:2.7 
		dev-lang/python:2.6 
	)
	dev-lang/vala:0.16
	dev-util/intltool
	sys-devel/gettext"

DOCS=(ChangeLog COPYING README)

src_prepare() {
	sed -i 's/indicate-0.5/indicate-0.6/' wscript
}

src_configure() {
	VALAC="$(type -p valac-0.16)" waf-utils_src_configure \
		--disable-docs --disable-zeitgeist --disable-libstemmer \
		$(use_enable ayatana libindicate)
}

src_install() {
	waf-utils_src_install
	base_src_install_docs
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

