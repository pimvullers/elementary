# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit gnome2-utils vala cmake-utils

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://launchpad.net/gala"
SRC_URI="https://code.launchpad.net/~elementary-os/+archive/stable/+files/gala_0.1-0%7Er363%2Bpkg18%2Br1%7Eubuntu12.04.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-libs/libgee:0
	media-libs/clutter
	media-libs/clutter-gtk
	pantheon-base/plank
	<x11-libs/granite-0.3
	x11-libs/bamf
	x11-libs/libXfixes
	>=x11-wm/mutter-3.4.1-r2
	<x11-wm/mutter-3.11"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_unpack() {
	default_src_unpack

	mv "${WORKDIR}/recipe-{debupstream}-0~r{revno}+pkg{revno:packaging}+r1" "${S}"
}

src_prepare() {
	epatch_user

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		--disable-gee-1.0
		-disable-gee-1.0
	)
	cmake-utils_src_configure
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
