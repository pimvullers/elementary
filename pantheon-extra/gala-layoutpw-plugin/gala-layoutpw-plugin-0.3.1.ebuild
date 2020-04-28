# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Gala plugin to switch layouts per window"
HOMEPAGE="https://github.com/Dirli/gala-layoutpw-plugin"
SRC_URI="https://github.com/Dirli/gala-layoutpw-plugin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

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
	dev-libs/libgee:0.8
	x11-wm/gala
	>=x11-wm/mutter-3.28.0:=
"

src_prepare() {
	default
	vala_src_prepare
}
