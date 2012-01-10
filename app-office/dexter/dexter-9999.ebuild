# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils bzr

DESCRIPTION="Dexter is a sexy, simple address book with end users in mind"
HOMEPAGE="https://launchpad.net/dexter-rolodex"
EBZR_REPO_URI="lp:dexter-rolodex"

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

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

