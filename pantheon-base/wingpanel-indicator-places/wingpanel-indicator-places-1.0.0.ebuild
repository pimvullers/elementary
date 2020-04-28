# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Wingpanel places indicator for disks, volumes and places management
"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-places"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-places/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

DEPEND="
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	pantheon-base/wingpanel
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

