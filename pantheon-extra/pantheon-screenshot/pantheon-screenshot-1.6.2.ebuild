# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.26

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Elementary Screenshot Tool"
HOMEPAGE="https://github.com/elementary/screenshot"
SRC_URI="https://github.com/elementary/screenshot/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-5.0
	media-libs/libcanberra
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

S=${WORKDIR}/screenshot-${PV}

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
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
