# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-12.10.0-r300.ebuild,v 1.2 2012/07/30 20:51:21 ssuominen Exp $

EAPI=5
inherit flag-o-matic autotools-utils

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/libindicator_12.10.2%2B14.04.20140402.orig.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.37:2
	>=x11-libs/gtk+-3.6:3
	>=x11-libs/libido-13.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/libindicator-12.10.2+14.04.20140402"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	autotools-utils_src_prepare
}

src_configure() {
	append-flags -Wno-error

	local myeconfargs=(
		--disable-silent-rules
		--disable-static
		--disable-tests
		--with-gtk=3
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	prune_libtool_files --all
}
