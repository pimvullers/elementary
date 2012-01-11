# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils autotools-utils

DESCRIPTION="A unified sound menu"
HOMEPAGE="https://launchpad.net/indicator-sound"
SRC_URI="http://launchpad.net/${PN}/fifth/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libgee
	dev-libs/libindicator:3
	dev-libs/libxml2
	gnome-base/gconf:2
	media-sound/pulseaudio[glib]
	x11-libs/gtk+:3
	x11-libs/libido:3
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-lang/vala:0.14
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	local myeconfargs=(
		VALAC="$(type -p valac-0.14)"
		--disable-schemas-compile
	)

	autotools-utils_src_configure
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

