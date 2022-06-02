# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.26

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="A tiny, simple calculator written in GTK+ and Vala"
HOMEPAGE="https://github.com/elementary/calculator"
SRC_URI="https://github.com/elementary/calculator/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
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
	dev-libs/granite:7
	>=gui-libs/libhandy-0.91.0:1
	gui-libs/gtk:4
"

S=${WORKDIR}/calculator-${PV}

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
