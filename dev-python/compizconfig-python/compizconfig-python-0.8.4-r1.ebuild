# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/compizconfig-python/compizconfig-python-0.8.4-r1.ebuild,v 1.3 2010/04/03 18:41:56 jmbsvicetto Exp $

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

DEPEND="
	>=dev-libs/glib-2.6
	dev-python/pyrex
	>=x11-libs/libcompizconfig-${PV}
"
RDEPEND="${DEPEND}"
