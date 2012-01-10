# Copyright 1999-2011 Gentoo Foundation
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
IUSE="static-libs"

RDEPEND="dev-libs/glib:2
	>=dev-libs/libdbusmenu-0.3.101[gtk]
	dev-libs/libgee
	>=dev-libs/libindicator-0.3.19
	dev-libs/libxml2:2
	gnome-base/gconf:2
	media-sound/pulseaudio[glib]
	x11-libs/gtk+:3
	x11-libs/libido
	>=x11-libs/libnotify-0.7"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12
	dev-util/pkgconfig"

DOCS=(AUTHORS)

src_configure() {
	local myeconfargs=(
		--disable-schemas-compile
	)

	autotools-utils_src_configure VALAC="$(type -p valac-0.12)"
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

