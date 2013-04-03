# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Dexter is a sexy, simple address book with end users in mind"
HOMEPAGE="https://launchpad.net/dexter-rolodex"
SRC_URI="http://launchpad.net/dexter-rolodex/0.x/${PV}/+download/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-python/vobject
	dev-python/storm
	dev-python/pyenchant
	dev-python/pyxdg"
DEPEND="${RDEPEND}
	dev-python/python-distutils-extra"

S="${WORKDIR}/dexter-rolodex"

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

