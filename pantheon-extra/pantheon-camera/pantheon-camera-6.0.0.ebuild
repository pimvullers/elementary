# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="The camera app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/camera"
SRC_URI="https://github.com/elementary/camera/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

DEPEND="
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/appstream
	dev-libs/glib:2
	>=dev-libs/granite-5.1
	dev-libs/libgee:0.8
	media-libs/clutter-gst:3.0
	media-libs/clutter-gtk:1.0
	media-libs/libcanberra
	>=x11-libs/gtk+-3.22:3
"
S=${WORKDIR}/camera-${PV}

src_prepare() {
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
