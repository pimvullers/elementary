# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit autotools-utils autotools-multilib

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="https://launchpad.net/libindicator"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/libindicator_12.10.2%2B14.04.20141007.orig.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64 ~arm x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.37:2[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-3.6:3[${MULTILIB_USEDEP}]
	>=x11-libs/libido-13.10.0[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig[${MULTILIB_USEDEP}]"

S="${WORKDIR}/libindicator-12.10.2+14.04.20141007"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	# https://bugs.launchpad.net/libindicator/+bug/1502925
	epatch "${FILESDIR}"/${PN}-12.10.2-ldflags-spacing.patch
	# respect gentoo libdir conventions for dependents' .so placement
	epatch "${FILESDIR}"/${PN}-12.10.2-indicatordir-in-libdir.patch
	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		--disable-silent-rules
		--disable-tests
		--with-gtk=3
	)

	autotools-utils_src_configure
}
