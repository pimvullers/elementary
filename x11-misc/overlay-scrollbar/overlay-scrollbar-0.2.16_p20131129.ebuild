# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

DESCRIPTION="Overlay Scrollbars use an overlay to ensure that scrollbars take up no active screen real-estate."
HOMEPAGE="https://launchpad.net/overlay-scrollbar"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/overlay-scrollbar_0.2.16%2Br359%2B14.04.20131129.orig.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	dev-libs/glib:2
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF=1
S="${WORKDIR}/overlay-scrollbar-0.2.16+r359+14.04.20131129"
GTKS="2 3"

src_prepare() {
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-tests
	)

	for gtk in ${GTKS}; do
		BUILD_DIR=${WORKDIR}/${P}_build${gtk} autotools-utils_src_configure --with-gtk=${gtk}
	done
}

src_compile() {
	for gtk in ${GTKS}; do
		BUILD_DIR=${WORKDIR}/${P}_build${gtk} autotools-utils_src_compile
	done
}

src_install() {
	for gtk in ${GTKS}; do
		BUILD_DIR=${WORKDIR}/${P}_build${gtk} autotools-utils_src_install
	done

	prune_libtool_files --all
}

