# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
SRC_URI="http://launchpad.net/ido/0.3/${PV}/+download/ido-${PV}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING ChangeLog NEWS README TODO )
	S="${WORKDIR}/ido-${PV}"
}