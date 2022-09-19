# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Small utility to print documents"
HOMEPAGE="https://github.com/elementary/print"
SRC_URI="https://github.com/elementary/print/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	pantheon-extra/contractor
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/print-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}

