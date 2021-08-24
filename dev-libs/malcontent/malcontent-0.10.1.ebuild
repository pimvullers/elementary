# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit meson vala xdg-utils

DESCRIPTION="Parental controls support library"
HOMEPAGE="https://gitlab.freedesktop.org/pwithnall/malcontent"
SRC_URI="https://gitlab.freedesktop.org/pwithnall/malcontent/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc nls"

RDEPEND="
	>=dev-libs/glib-2.50:2
"

DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

