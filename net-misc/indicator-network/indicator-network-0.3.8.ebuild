# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vala autotools-utils

DESCRIPTION="Network Menu for controlling network connections"
HOMEPAGE="https://launchpad.net/indicator-network"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-network_0.3.8.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libindicator:3"
DEPEND="${RDEPEND}
	$(vala_depend)"

AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch "${FILESDIR}/gtk3-vala-port.patch"
	epatch "${FILESDIR}/generate_vapi.patch"
	epatch "${FILESDIR}/${P}-no-fatal-warnings.patch"
	epatch_user

	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		VALAC=${VALAC}
	)

	autotools-utils_src_configure
}
