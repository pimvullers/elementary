# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="The Date and Time Indicator - A very, very simple clock"
HOMEPAGE="https://launchpad.net/indicator-datetime"
EBZR_REPO_URI="lp:indicator-datetime"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	x11-libs/libido"
DEPEND="${RDEPEND}"

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

