# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compiz-bcop/compiz-bcop-0.8.4.ebuild,v 1.1 2009/10/15 16:35:51 mrpouet Exp $

DESCRIPTION="Compiz Option code Generator"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxslt"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
