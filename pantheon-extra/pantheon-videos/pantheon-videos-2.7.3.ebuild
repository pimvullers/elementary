# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Video player and library app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/videos"
SRC_URI="https://github.com/elementary/videos/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee:0.8
	media-libs/clutter-gst:3.0
	media-libs/clutter-gtk:1.0[gtk]
	media-plugins/gst-plugins-meta
	media-libs/gstreamer:1.0
	media-libs/libdvbpsi
	media-libs/libmad
	media-libs/libsamplerate
	>=x11-libs/gtk+-3.22:3
"

S=${WORKDIR}/videos-${PV}

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
