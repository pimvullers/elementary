# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/compizconfig-python/compizconfig-python-0.8.4.ebuild,v 1.1 2009/10/15 17:35:19 mrpouet Exp $

inherit python

DESCRIPTION="Compizconfig Python Bindings"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	>=dev-lang/python-2.4
	>=dev-libs/glib-2.6
	dev-python/pyrex
	~x11-libs/libcompizconfig-${PV}"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	python_need_rebuild
}
