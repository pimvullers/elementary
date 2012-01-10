# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="Network indicator"
HOMEPAGE="https://launchpad.net/indicator-network"
EBZR_REPO_URI="lp:~and471/indicator-network/gtk3"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# Fix libindicator dependency in configure.ac
	epatch "${FILESDIR}/${PN}-libindicator3.patch"

	eautoreconf
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		--srcdir="${S}"
	)

	autotools-utils_src_configure VALAC="$(type -p valac-0.14)"
}

