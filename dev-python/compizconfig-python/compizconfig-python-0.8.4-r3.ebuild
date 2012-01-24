# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/compizconfig-python/compizconfig-python-0.8.4-r3.ebuild,v 1.1 2010/09/08 22:18:08 flameeyes Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python

RESTRICT_PYTHON_ABIS="3.*"

DESCRIPTION="Compizconfig Python Bindings"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.6
	>=x11-libs/libcompizconfig-${PV}"

DEPEND="${RDEPEND}
	dev-python/pyrex
	dev-util/pkgconfig"

src_configure() {
	python_src_configure \
		--disable-dependency-tracking \
		--enable-fast-install \
		--disable-static
}

src_install() {
	python_src_install
	python_clean_installation_image
}
