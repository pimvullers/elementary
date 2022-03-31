# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="The camera app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/camera"
SRC_URI="https://github.com/elementary/camera/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0
	dev-libs/libgee:0.8
	media-libs/libcanberra
	gui-libs/libhandy
	media-libs/gstreamer
	x11-libs/gtk+:3
"
S=${WORKDIR}/camera-${PV}

src_prepare() {
	eapply ${FILESDIR}/216.diff

	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
}
