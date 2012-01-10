# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

MY_PN=${PN/lib}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
SRC_URI="http://launchpad.net/ido/trunk/${PV}/+download/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS=(AUTHORS)

src_prepare() {
#	epatch "${FILESDIR}"/${P}-remove-ubuntu.patch
	sed -i 's/ubuntu_//' src/idoscalemenuitem.c
}

