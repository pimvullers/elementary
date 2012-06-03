# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.4.1-r300.ebuild,v 1.1 2011/11/26 16:25:05 ssuominen Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator"
SRC_URI="http://launchpad.net/${PN}/0.5/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!<${CATEGORY}/${PN}-0.4.1-r201"

src_prepare() {
	sed -i -e 's:-Werror::' {libindicator,tests,tools}/Makefile.{am,in} || die

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-gtk=3
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	rm -f "${ED}"usr/lib*/*.la
}
