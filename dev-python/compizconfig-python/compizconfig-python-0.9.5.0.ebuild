# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Compizconfig Python Bindings"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.6
	dev-python/cython
	=x11-libs/libcompizconfig-${PV}*
	=x11-wm/compiz-${PV}*"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS="AUTHORS COPYING ChangeLog NEWS README TODO VERSION"
}

