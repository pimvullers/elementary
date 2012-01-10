# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="A unified sound menu"
HOMEPAGE="https://launchpad.net/indicator-sound"
EBZR_REPO_URI="lp:indicator-sound"

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
	dev-lang/vala:0.14
	dev-util/pkgconfig"

DOCS=(AUTHORS)

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myeconfargs=(
		VALAC=$(type -p valac-0.14)
	)

	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile -j1
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

