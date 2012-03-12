# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils waf-utils git-2

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="http://redmine.yorba.org/projects/geary/wiki"
EGIT_REPO_URI="git://yorba.org/geary"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-db/sqlheavy:0.2
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libgee
	dev-libs/libunique:3
	dev-libs/gmime:2.4
	gnome-base/libgnome-keyring
	net-libs/webkit-gtk:3
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS MAINTAINERS)
}

src_configure() {
	VALAC="$(type -p valac-0.16)" \
	GLIB_COMPILE_SCHEMAS="/bin/true" \
	waf-utils_src_configure
}

src_install() {
	waf-utils_src_install
	base_src_install_docs
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

