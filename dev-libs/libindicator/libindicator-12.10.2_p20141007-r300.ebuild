# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit flag-o-matic autotools-utils autotools-multilib

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="https://launchpad.net/libindicator"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/libindicator_12.10.2%2B14.04.20140402.orig.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.37:2[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-3.6:3[${MULTILIB_USEDEP}]
	>=x11-libs/libido-13.10[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig[${MULTILIB_USEDEP}]"

S="${WORKDIR}/libindicator-12.10.2+14.04.20140402"
AUTOTOOLS_AUTORECONF=1

multilib_src_configure() {
	append-flags -Wno-error

	local myeconfargs=(
		--disable-silent-rules
		--disable-static
		--disable-tests
		--with-gtk=3
	)

	autotools-utils_src_configure
}
