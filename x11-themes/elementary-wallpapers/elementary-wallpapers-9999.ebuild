# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit base bzr

DESCRIPTION="A set of wallpapers used by the elementary OS"
HOMEPAGE="http://www.elementaryos.org"
SRC_URI="http://www.vullerscode.nl/elementary/distfiles/${P}.tar.bz2"
EBZR_REPO_URI="lp:~elementary-design/+junk/elementarywalls"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	bzr_src_unpack
	base_src_unpack
}

src_install() {
	insinto /usr/share/backgrounds/elementary
	doins *.jpg *.png
}

