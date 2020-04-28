# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Gala plugin to restore windows after reboot"
HOMEPAGE="https://github.com/Dirli/gala-savewins-plugin"
SRC_URI="https://github.com/Dirli/gala-savewins-plugin/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/libgee:0.8
	x11-libs/bamf
	x11-wm/gala
	>=x11-wm/mutter-3.28.0:=
"

src_prepare() {
	default
	vala_src_prepare
}
