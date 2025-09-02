# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="A tiny, simple calculator written in GTK+ and Vala"
HOMEPAGE="https://github.com/elementary/calculator"
SRC_URI="https://github.com/elementary/calculator/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/calculator-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

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

src_prepare() {
	eapply_user
	vala_setup
}
