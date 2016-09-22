# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools bzr

DESCRIPTION="Online Accounts Sign-on glib daemon"
HOMEPAGE="https://launchpad.net/gsignond"
EBZR_REPO_URI="lp:gsignond"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	eautoreconf

	default
}
